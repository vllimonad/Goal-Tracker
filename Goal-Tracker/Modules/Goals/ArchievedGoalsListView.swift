//
//  ContentView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 09/09/2025.
//

import SwiftUI
import SwiftData

struct ArchievedGoalsListView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(
        filter: #Predicate<GoalModel> {
            $0.isArchived
        },
        sort: \GoalModel.creationDate
    )
    private var goals: [GoalModel]
    
    @State private var selectedGoal: GoalModel? = nil
    @State private var isDeleteAlertPresented: Bool = false
    @State private var isDeleteAllAlertPresented: Bool = false
        
    var body: some View {
        List(goals) { goal in
            GoalProgressView(goal: goal)
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 0, leading: 24, bottom: 0, trailing: 24))
                .listRowBackground(Color.bgMain)
                .swipeActions(edge: .trailing) {
                    Button("delete", role: .destructive) {
                        selectedGoal = goal
                        isDeleteAlertPresented = true
                    }
                    .tint(.red)
                    
                    Button("unarchive") {
                        unarchiveGoal(goal)
                    }
                    .tint(.orange)
                }
        }
        .background(Color.bgMain)
        .listRowSpacing(12)
        .listStyle(.plain)
        .navigationTitle(LocalizedStringKey("archived.goals"))
        .toolbarTitleDisplayMode(.inline)
        .toolbarVisibility(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isDeleteAllAlertPresented = true
                } label: {
                    Image(systemName: "xmark.bin")
                        .foregroundStyle(.red)
                }
            }
        }
        .alert("delete.all.archived.goals?", isPresented: $isDeleteAllAlertPresented) {
            Button(role: .cancel) { }
            Button("delete.all", role: .destructive, action: deleteAllGoals)
        }
        .alert("delete.this.goal?", isPresented: $isDeleteAlertPresented) {
            Button(role: .cancel) { }
            Button("delete", role: .destructive, action: deleteGoal)
        }
    }
    
    private func deleteGoal() {
        guard let goal = selectedGoal else { return }
        
        modelContext.delete(goal)
        selectedGoal = nil
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
    ArchievedGoalsListView()
}
