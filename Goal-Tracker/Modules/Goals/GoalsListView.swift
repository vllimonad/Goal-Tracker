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
    
    @Query(sort: \GoalModel.creationDate) private var goals: [GoalModel]
    
    @State private var selectedGoal: GoalModel? = nil
    
    var body: some View {
        NavigationView {
            List(goals) { goal in
                GoalProgressView(goal: goal)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 0, leading: 24, bottom: 0, trailing: 24))
                    .listRowBackground(Color.bgMain)
                    .swipeActions(edge: .trailing) {
                        Button("goals.delete.action.title", role: .destructive) {
                            modelContext.delete(goal)
                        }
                        .tint(.red)
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
            .sheet(item: $selectedGoal) { goal in
                NewRecordView(goal: goal)
                    .presentationDetents([.height(180)])
            }
        }
    }
}

#Preview {
    GoalsListView()
}
