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
                    .listRowInsets(.vertical, 0)
                    .listRowInsets(.horizontal, 24)
                    .listRowBackground(Color.clear)
                    .swipeActions(edge: .trailing) {
                        Button("delete", role: .destructive) {
                            deleteGoal(goal)
                        }
                        .tint(.red)
                        
                        Button("edit", role: .close) {
                            
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
                    .contextMenu {
                        Button("edit", systemImage: "pencil", role: .confirm) {
                            
                        }
                        .tint(.black)
                        
                        Button("archive", systemImage: "archivebox") {
                            archiveGoal(goal)
                        }
                        .tint(.black)
                        
                        Button("delete", systemImage: "xmark.bin", role: .destructive) {
                            deleteGoal(goal)
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
            .navigationDestination(item: $isArchivePresented, destination: { _ in
                ArchievedGoalsListView()
            })
            .sheet(item: $selectedGoal) { goal in
                NewRecordView(goal: goal)
                    .presentationDetents([
                        .height(180)
                    ])
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
