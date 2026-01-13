//
//  MainView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 27/09/2025.
//

import SwiftUI

struct MainTabView: View {
    
    enum TabType {
        case goals, stats, newGoal
    }
    
    @State private var selectedTab: TabType = .goals
    @State private var isNewGoalPresented: Bool = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(
                "goals.title",
                image: selectedTab == .goals ? "tab_goals_colored" : "tab_goals",
                value: .goals
            ) {
                NavigationStack {
                    GoalsListView()
                }
            }
                        
            Tab(
                "stats.title",
                image: selectedTab == .stats ? "tab_stats_colored" : "tab_stats",
                value: .stats
            ) {
                NavigationStack {
                    StatsView()
                }
            }
            
            Tab(
                "new.goal.title",
                systemImage: "plus",
                value: .newGoal,
                role: .search
            ) {
                EmptyView()
            }
        }
        .tint(.textBlue)
        .onChange(of: selectedTab) { oldValue, newValue in
            if newValue == .newGoal {
                isNewGoalPresented = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    selectedTab = oldValue
                }
            }
        }
        .sheet(isPresented: $isNewGoalPresented) {
            NavigationView {
                NewGoalView()
            }
        }

    }
}

#Preview {
    MainTabView()
}
