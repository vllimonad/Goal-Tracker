//
//  ContentView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 09/09/2025.
//

import SwiftUI
import SwiftData
import WidgetKit

struct GoalsListView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(
        filter: #Predicate<GoalModel> { !$0.isArchived },
        sort: [
            SortDescriptor(\GoalModel.sortIndex),
            SortDescriptor(\GoalModel.creationDate, order: .reverse)
        ]
    )
    private var goals: [GoalModel]
    
    @State private var selectedGoal: GoalModel? = nil
    @State private var goalToDelete: GoalModel? = nil
    @State private var goalToEdit: GoalModel? = nil

    @State private var isDeleteAlertPresented: Bool = false
    @State private var isDeleteSelectionAlertPresented: Bool = false
    @State private var isArchiveSelectionAlertPresented: Bool = false
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
        .navigationTitle(editMode.isEditing ? "" : "goals.title")
        .toolbarVisibility(editMode.isEditing ? .hidden : .visible, for: .tabBar)
        .toolbarTitleDisplayMode(.inlineLarge)
        .toolbar {
            toolBarContent()
        }
        .navigationDestination(item: $goalToEdit) {
            editGoalView(for: $0)
        }
        .sheet(item: $selectedGoal) {
            newRecordsViewSheet(for: $0)
        }
        .alert(
            "delete.goal \(goalToDelete?.name ?? "")?",
            isPresented: $isDeleteAlertPresented
        ) {
            alertActions(
                title: "goals.alert.delete.action.title",
                action: deleteGoal
            )
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
            "goals.alert.archive.title",
            isPresented: $isArchiveSelectionAlertPresented
        ) {
            alertActions(
                title: "goals.alert.archive.action.title",
                action: archiveSelectedGoals
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
            .listRowBackground(Color.clear)
            .swipeActions(edge: .trailing) {
                swipeActions(for: goal)
            }
            .contextMenu {
                contextMenu(for: goal)
            } preview: {
                GoalProgressView(goal: goal)
                    .frame(width: 300)
            }
            .onTapGesture {
                selectedGoal = goal
            }
            .disabled(editMode.isEditing)
    }
    
    private func editGoalView(for goal: GoalModel) -> some View {
        EditGoalView(goal: goal)
            .toolbarVisibility(.hidden, for: .tabBar)
    }
    
    private func newRecordsViewSheet(for goal: GoalModel) -> some View {
        NewRecordView(goal: goal)
            .presentationDetents([
                .height(180)
            ])
    }
    
    @ViewBuilder
    private func swipeActions(for goal: GoalModel) -> some View {
        Button("goal.delete.action.title") {
            prepareForDeletion(goal)
        }
        .tint(.red)

        Button("goal.archive.action.title", role: .destructive) {
            archiveGoal(goal)
        }
        .tint(.orange)

        Button("goal.edit.action.title") {
            editGoal(goal)
        }
        .tint(.iconBlue)
    }
    
    @ViewBuilder
    private func contextMenu(for goal: GoalModel) -> some View {
        Button("goal.edit.action.title", systemImage: "pencil") {
            editGoal(goal)
        }
        .tint(.iconPrimary)
        
        Button("goal.archive.action.title", systemImage: "archivebox") {
            archiveGoal(goal)
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
                    isArchiveSelectionAlertPresented = true
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
        
        ToolbarSpacer(.fixed, placement: .topBarTrailing)
        
        ToolbarItem(placement: .topBarTrailing) {
            if editMode.isEditing == false {
                NavigationLink {
                    ArchivedGoalsListView()
                        .toolbarVisibility(.hidden, for: .tabBar)
                } label: {
                    Image(systemName: "archivebox")
                        .foregroundStyle(.iconPrimary)
                }
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
            "goals.empty.title",
            systemImage: "zzz",
            description: Text("goals.empty.description")
        )
    }
    
    private func editGoal(_ goal: GoalModel) {
        goalToEdit = goal
    }
    
    private func deleteGoal() {
        guard let goal = goalToDelete else { return }
        
        modelContext.delete(goal)
        
        withAnimation(.easeInOut) {
            goalToDelete = nil
        }
        
        try? modelContext.save()
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    private func archiveGoal(_ goal: GoalModel) {
        goal.isArchived = true
    }
    
    private func archiveSelectedGoals() {
        goals
            .filter { selection.contains($0.id) }
            .forEach { archiveGoal($0) }
        
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
    
    private func prepareForDeletion(_ goal: GoalModel) {
        goalToDelete = goal
        isDeleteAlertPresented = true
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
    GoalsListView()
}
