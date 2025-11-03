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
    @State private var deleteAlertGoal: GoalModel? = nil
    @State private var isDeleteAlertPresented: Bool = false
    @State private var isArchivePresented: Bool? = nil
    
    var body: some View {
        NavigationStack {
            List(goals) { goal in
                GoalProgressView(goal: goal)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.vertical, 0)
                    .listRowInsets(.horizontal, 24)
                    .listRowBackground(Color.clear)
                    .swipeActions(edge: .trailing) {
                        Button("delete") {
                            prepareForDeletion(goal)
                        }
                        .tint(.red)
                        
                        Button("edit") {
                            
                        }
                        .tint(.iconBlue)
                    }
                    .swipeActions(edge: .leading) {
                        Button("archive", role: .destructive) {
                            archiveGoal(goal)
                        }
                        .tint(.orange)
                    }
                    .onTapGesture {
                        selectedGoal = goal
                    }
                    .contextMenu {
                        Button("edit", systemImage: "pencil") {
                            
                        }
                        .tint(.black)
                        
                        Button("archive", systemImage: "archivebox") {
                            archiveGoal(goal)
                        }
                        .tint(.black)
                        
                        Button("delete", systemImage: "xmark.bin") {
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
            .navigationTitle(LocalizedStringKey("goals.title"))
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isArchivePresented = true
                    } label: {
                        Image(systemName: "archivebox")
                            .foregroundStyle(.black)
                    }
                }
            }
            .navigationDestination(item: $isArchivePresented) { _ in
                ArchievedGoalsListView()
            }
            .sheet(item: $selectedGoal) { goal in
                NewRecordView(goal: goal)
                    .presentationDetents([
                        .height(180)
                    ])
            }
            .alert("delete.goal '\(deleteAlertGoal?.name ?? "")'?", isPresented: $isDeleteAlertPresented) {
                Button(role: .cancel) { }
                Button("delete", role: .destructive, action: deleteGoal)
            }
        }
    }
    
    private func deleteGoal() {
        guard let goal = deleteAlertGoal else { return }
        
        modelContext.delete(goal)
        
        deleteAlertGoal = nil
    }
    
    private func archiveGoal(_ goal: GoalModel) {
        goal.isArchived = true
    }
    
    private func prepareForDeletion(_ goal: GoalModel) {
        deleteAlertGoal = goal
        isDeleteAlertPresented = true
    }
}

#Preview {
    GoalsListView()
}
