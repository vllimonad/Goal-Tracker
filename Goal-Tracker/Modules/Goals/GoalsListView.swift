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
        filter: #Predicate<GoalModel> {
            !$0.isArchived
        },
        sort: \GoalModel.creationDate
    )
    private var goals: [GoalModel]
    
    @State private var selectedGoal: GoalModel? = nil
    @State private var isArchivePresented: Bool? = nil
    
    var body: some View {
        NavigationStack {
            List(goals) { goal in
                GoalProgressView(goal: goal)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 0, leading: 24, bottom: 0, trailing: 24))
                    .listRowBackground(Color.bgMain)
                    .swipeActions(edge: .trailing) {
                        Button("delete", role: .destructive) {
                            deleteGoal(goal)
                        }
                        .tint(.red)
                        
                        Button("change", role: .close) {
                            
                        }
                        .tint(.iconBlue)
                    }
                    .swipeActions(edge: .leading) {
                        Button("archive") {
                            archiveGoal(goal)
                        }
                        .tint(.orange)
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
            .navigationDestination(item: $isArchivePresented, destination: { _ in
                ArchievedGoalsListView()
            })
            .sheet(item: $selectedGoal) { goal in
                NewRecordView(goal: goal)
                    .presentationDetents([.height(180)])
            }
        }
    }
    
    func deleteGoal(_ goal: GoalModel) {
        modelContext.delete(goal)
    }
    
    func archiveGoal(_ goal: GoalModel) {
        goal.isArchived = true
    }
}

#Preview {
    GoalsListView()
}
