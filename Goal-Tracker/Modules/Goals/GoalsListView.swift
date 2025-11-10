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
        filter: #Predicate<GoalModel> { !$0.isArchived && !$0.isDeleted },
        sort: \GoalModel.creationDate
    )
    private var goals: [GoalModel]
    
    @State private var selectedGoal: GoalModel? = nil
    @State private var goalToDelete: GoalModel? = nil
    @State private var goalToEdit: GoalModel? = nil

    @State private var isDeleteAlertPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            List(goals) { goal in
                GoalProgressView(goal: goal)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.vertical, 0)
                    .listRowInsets(.horizontal, 24)
                    .listRowBackground(Color.clear)
                    .swipeActions(edge: .trailing) {
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
                    .contextMenu {
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
                    } preview: {
                        GoalProgressView(goal: goal)
                            .frame(width: 300)
                    }
                    .onTapGesture {
                        selectedGoal = goal
                    }
            }
            .background(Color.bgMain)
            .listRowSpacing(12)
            .listStyle(.plain)
            .navigationTitle(LocalizedStringKey("goals.title"))
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbarVisibility(.visible, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        ArchivedGoalsListView()
                    } label: {
                        Image(systemName: "archivebox")
                            .foregroundStyle(.iconPrimary)
                    }
                }
            }
            .navigationDestination(item: $goalToEdit) { goal in
                EditGoalView(goal: goal)
            }
            .sheet(item: $selectedGoal) { goal in
                NewRecordView(goal: goal)
                    .presentationDetents([
                        .height(180)
                    ])
            }
            .alert("delete.goal '\(goalToDelete?.name ?? "")'?", isPresented: $isDeleteAlertPresented) {
                Button(role: .cancel) { }
                Button("goals.alert.delete.action.title", role: .destructive, action: deleteGoal)
            }
            .overlay {
                if goals.isEmpty {
                    ContentUnavailableView(
                        "goals.empty.title",
                        systemImage: "zzz",
                        description: Text("goals.empty.description")
                    )
                }
            }
        }
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
