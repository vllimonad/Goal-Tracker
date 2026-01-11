//
//  ContentView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 09/09/2025.
//

import SwiftUI
import SwiftData

struct ArchivedGoalsListView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(
        filter: #Predicate<GoalModel> { $0.isArchived },
        sort: \GoalModel.creationDate
    )
    private var goals: [GoalModel]
    
    @State private var selectedGoal: GoalModel? = nil
    @State private var isDeleteAlertPresented: Bool = false
    @State private var isDeleteAllAlertPresented: Bool = false
        
    var body: some View {
        List(goals) {
            goalView(for: $0)
        }
        .background(.bgPage)
        .listRowSpacing(12)
        .listStyle(.plain)
        .navigationTitle("archived.goals.title")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            toolBarContent()
        }
        .alert(
            "archived.goals.delete.all.alert.title",
            isPresented: $isDeleteAllAlertPresented
        ) {
            deleteAllAlertActions()
        }
        .alert(
            "archived.goals.delete.alert.title",
            isPresented: $isDeleteAlertPresented
        ) {
            deleteAlertActions()
        }
        .overlay {
            if goals.isEmpty {
                contentUnavailableView()
            }
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
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                isDeleteAllAlertPresented = true
            } label: {
                Image(systemName: "xmark.bin")
                    .foregroundStyle(.red)
            }
        }
    }
    
    @ViewBuilder
    private func deleteAllAlertActions() -> some View {
        Button(role: .cancel) { }
        
        Button("delete.all", role: .destructive, action: deleteAllGoals)
    }
    
    @ViewBuilder
    private func deleteAlertActions() -> some View {
        Button(role: .cancel) { }
        
        Button("delete", role: .destructive, action: deleteGoal)
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
        
        withAnimation(.snappy) {
            selectedGoal = nil
        }
    }
    
    private func deleteAllGoals() {
        goals.forEach {
            modelContext.delete($0)
        }
    }
    
    private func unarchiveGoal(_ goal: GoalModel) {
        goal.isArchived = false
    }
}

#Preview {
    ArchivedGoalsListView()
}
