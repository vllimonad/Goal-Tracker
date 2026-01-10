//
//  ContentView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 09/09/2025.
//

import SwiftUI
import SwiftData

struct GoalsListView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(
        filter: #Predicate<GoalModel> { !$0.isArchived },
        sort: \GoalModel.creationDate
    )
    private var goals: [GoalModel]
    
    @State private var selectedGoal: GoalModel? = nil
    @State private var goalToDelete: GoalModel? = nil
    @State private var goalToEdit: GoalModel? = nil

    @State private var isDeleteAlertPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            List(goals) {
                goalView(for: $0)
            }
            .background(.bgPage)
            .listRowSpacing(12)
            .listStyle(.plain)
            .navigationTitle("goals.title")
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
                alertActions()
            }
            .overlay {
                if goals.isEmpty {
                    contentUnavailableView()
                }
            }
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
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink {
                ArchivedGoalsListView()
            } label: {
                Image(systemName: "archivebox")
                    .foregroundStyle(.iconPrimary)
            }
        }
    }
    
    @ViewBuilder
    private func alertActions() -> some View {
        Button(role: .cancel) { }
        
        Button(
            "goals.alert.delete.action.title",
            role: .destructive,
            action: deleteGoal
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
        goalToDelete = nil
    }
    
    private func archiveGoal(_ goal: GoalModel) {
        goal.isArchived = true
    }
    
    private func prepareForDeletion(_ goal: GoalModel) {
        goalToDelete = goal
        isDeleteAlertPresented = true
    }
}

#Preview {
    GoalsListView()
}
