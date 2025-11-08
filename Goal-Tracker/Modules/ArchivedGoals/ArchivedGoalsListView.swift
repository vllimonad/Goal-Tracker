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
        List(goals) { goal in
            GoalProgressView(goal: goal)
                .listRowSeparator(.hidden)
                .listRowInsets(.vertical, 0)
                .listRowInsets(.horizontal, 24)
                .listRowBackground(Color.bgMain)
                .swipeActions(edge: .trailing) {
                    Button("goal.delete.action.title") {
                        prepareForDeletion(goal)
                    }
                    .tint(.red)
                    
                    Button("goal.unarchive.action.title", role: .destructive) {
                        unarchiveGoal(goal)
                    }
                    .tint(.orange)
                }
                .contextMenu {
                    Button("goal.unarchive.action.title", systemImage: "archivebox") {
                        unarchiveGoal(goal)
                    }
                    .tint(.black)
                    
                    Button("goal.delete.action.title", systemImage: "xmark.bin") {
                        prepareForDeletion(goal)
                    }
                    .tint(.red)
                } preview: {
                    GoalProgressView(goal: goal)
                        .frame(width: 300)
                }
        }
        .background(Color.bgMain)
        .listRowSpacing(12)
        .listStyle(.plain)
        .navigationTitle(LocalizedStringKey("archived.goals.title"))
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
        .alert("archived.goals.delete.all.alert.title", isPresented: $isDeleteAllAlertPresented) {
            Button(role: .cancel) { }
            Button("delete.all", role: .destructive, action: deleteAllGoals)
        }
        .alert("archived.goals.delete.alert.title", isPresented: $isDeleteAlertPresented) {
            Button(role: .cancel) { }
            Button("delete", role: .destructive, action: deleteGoal)
        }
        .overlay {
            if goals.isEmpty {
                ContentUnavailableView(
                    "archived.goals.empty.title",
                    systemImage: "archivebox",
                    description: Text("archived.goals.empty.description")
                )
            }
        }
    }
    
    private func prepareForDeletion(_ goal: GoalModel) {
        selectedGoal = goal
        isDeleteAlertPresented = true
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
    ArchivedGoalsListView()
}
