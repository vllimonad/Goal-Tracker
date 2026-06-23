//
//  ContentView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 09/09/2025.
//

import SwiftUI
import SwiftData
import WidgetKit

struct ArchivedGoalsListView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(
        filter: #Predicate<GoalModel> { $0.isArchived },
        sort: [
            SortDescriptor(\GoalModel.sortIndex),
            SortDescriptor(\GoalModel.creationDate, order: .reverse)
        ]
    )
    private var goals: [GoalModel]
    
    @State private var selectedGoal: GoalModel? = nil
    
    @State private var isDeleteAlertPresented: Bool = false
    @State private var isDeleteSelectionAlertPresented: Bool = false
    @State private var isUnarchiveSelectionAlertPresented: Bool = false
    @State private var didSelectAll: Bool = false
    
    @State private var selection = Set<GoalModel.ID>()
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        List(selection: $selection) {
            ForEach(goals) {
                goalView(for: $0)
            }
            .onMove(perform: moveGoal)
        }
        .environment(\.editMode, $editMode)
        .background(.bgPage)
        .listRowSpacing(12)
        .listStyle(.plain)
        .navigationTitle(editMode.isEditing ? "" : "archived.goals.title")
        .toolbarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(editMode.isEditing)
        .toolbar {
            toolBarContent()
        }
        .alert(
            "archived.goals.delete.alert.title",
            isPresented: $isDeleteAlertPresented
        ) {
            alertActions(title: "delete", action: deleteGoal)
        }
        .alert(
            "goals.alert.delete.title",
            isPresented: $isDeleteSelectionAlertPresented
        ) {
            alertActions(
                title: "goals.alert.delete.action.title",
                action: deleteSelectedGoals
            )
        }
        .alert(
            "goals.alert.unarchive.title",
            isPresented: $isUnarchiveSelectionAlertPresented
        ) {
            alertActions(
                title: "goals.alert.unarchive.action.title",
                action: unarchiveSelectedGoals
            )
        }
        .overlay {
            if goals.isEmpty {
                contentUnavailableView()
            }
        }
        .onChange(of: selection) { _, _ in
            didSelectAll = selection.count == goals.count && !goals.isEmpty
        }
    }
    
    private func goalView(for goal: GoalModel) -> some View {
        GoalProgressView(goal: goal)
            .listRowSeparator(.hidden)
            .listRowInsets(.vertical, 0)
            .listRowInsets(.horizontal, 20)
            .listRowBackground(Color.bgPage)
            .swipeActions(edge: .trailing) {
                swipeActions(for: goal)
            }
            .contextMenu {
                contextMenu(for: goal)
            } preview: {
                GoalProgressView(goal: goal)
                    .frame(width: 300)
            }
            .disabled(editMode.isEditing)
    }
    
    @ViewBuilder
    private func swipeActions(for goal: GoalModel) -> some View {
        Button("goal.delete.action.title") {
            prepareForDeletion(goal)
        }
        .tint(.red)
        
        Button("goal.unarchive.action.title", role: .destructive) {
            unarchiveGoal(goal)
        }
        .tint(.orange)
    }
    
    @ViewBuilder
    private func contextMenu(for goal: GoalModel) -> some View {
        Button("goal.unarchive.action.title", systemImage: "archivebox") {
            unarchiveGoal(goal)
        }
        .tint(.iconPrimary)
        
        Button(
            "goal.delete.action.title",
            systemImage: "xmark.bin",
            role: .destructive
        ) {
            prepareForDeletion(goal)
        }
        .tint(.red)
    }
    
    @ToolbarContentBuilder
    private func toolBarContent() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            if editMode.isEditing == true {
                Button("", systemImage: "archivebox") {
                    isUnarchiveSelectionAlertPresented = true
                }
                .tint(.orange)
                
                Button("", systemImage: "xmark.bin") {
                    isDeleteSelectionAlertPresented = true
                }
                .tint(.red)
            }
        }
        
        ToolbarSpacer(.fixed, placement: .topBarTrailing)
        
        ToolbarItem(placement: .topBarTrailing) {
            if goals.count > 1 {
                Button(editMode.isEditing ? "Done" : "Edit") {
                    withAnimation {
                        editMode = editMode.isEditing ? .inactive : .active
                    }
                }
                .tint(.iconPrimary)
            }
        }
        
        ToolbarItem(placement: .topBarLeading) {
            if editMode.isEditing == true {
                Button(didSelectAll ? "Deselect All" : "Select All") {
                    if didSelectAll {
                        deselectAllGoals()
                    } else {
                        selectAllGoals()
                    }
                }
                .tint(.iconPrimary)
                .contentTransition(.opacity)
                .animation(.default, value: didSelectAll)
            }
        }
    }
    
    @ViewBuilder
    private func alertActions(title: LocalizedStringKey, action: @escaping () -> Void) -> some View {
        Button(role: .cancel) { }
        
        Button(
            title,
            role: .destructive,
            action: action
        )
    }
    
    private func contentUnavailableView() -> some View {
        ContentUnavailableView(
            "archived.goals.empty.title",
            systemImage: "archivebox",
            description: Text("archived.goals.empty.description")
        )
    }
    
    private func prepareForDeletion(_ goal: GoalModel) {
        selectedGoal = goal
        isDeleteAlertPresented = true
    }
    
    private func deleteGoal() {
        guard let goal = selectedGoal else { return }
        
        modelContext.delete(goal)
        
        withAnimation(.easeInOut) {
            selectedGoal = nil
        }
        
        try? modelContext.save()
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    private func unarchiveGoal(_ goal: GoalModel) {
        goal.isArchived = false
        goal.sortIndex = 0
        
        try? modelContext.save()
    }
    
    private func unarchiveSelectedGoals() {
        goals
            .filter { selection.contains($0.id) }
            .forEach { unarchiveGoal($0) }
        
        withAnimation {
            selection.removeAll()
            editMode = .inactive
        }
    }

    private func deleteSelectedGoals() {
        let toDelete = goals.filter { selection.contains($0.id) }
        for goal in toDelete {
            modelContext.delete(goal)
        }
        
        withAnimation {
            selection.removeAll()
            editMode = .inactive
        }
        
        try? modelContext.save()
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    private func selectAllGoals() {
        selection = Set(goals.map { $0.id })
    }
    
    private func deselectAllGoals() {
        selection.removeAll()
    }
    
    private func moveGoal(from source: IndexSet, to destination: Int) {
        var reorderedGoals = goals
        reorderedGoals.move(fromOffsets: source, toOffset: destination)
        for (index, goal) in reorderedGoals.enumerated() {
            goal.sortIndex = index
        }
    }
}

#Preview {
    ArchivedGoalsListView()
}
