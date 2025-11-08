//
//  MainView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 27/09/2025.
//

import SwiftUI

struct MainView: View {
    
    @State private var selectedTab: TabType = .goals
    @State private var didTapNewGoalTab: Bool = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(
                "goals.title",
                image: selectedTab == .goals ? "tab_goals_colored" : "tab_goals",
                value: .goals
            ) {
                GoalsListView()
            }
                        
            Tab(
                "stats.title",
                image: selectedTab == .stats ? "tab_stats_colored" : "tab_stats",
                value: .stats
            ) {
                StatsView()
            }
            
            Tab(
                "new.goal.title",
                image: "tab_new_goal",
                value: .newGoal,
                role: .search
            ) {
                EmptyView()
            }
        }
        .tint(.textBlue)
        .onChange(of: selectedTab, { oldValue, newValue in
            if newValue == .newGoal {
                didTapNewGoalTab = true
                selectedTab = oldValue
            }
        })
        .sheet(isPresented: $didTapNewGoalTab) {
            NewGoalView()
        }
    }
}

enum TabType {
    case goals, stats, newGoal
}

#Preview {
    MainView()
}
