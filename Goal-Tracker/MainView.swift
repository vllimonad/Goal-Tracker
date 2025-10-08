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
            Tab("goals.title",
                image: selectedTab == .goals ? "tab.goals.colored" : "tab.goals",
                value: .goals) {
                GoalsListView()
            }
                        
            Tab("stats.title",
                image: selectedTab == .stats ? "tab.stats.colored" : "tab.stats",
                value: .stats) {
                GoalsListView()
            }
            
            Tab("new.goal.title",
                image: "tab.new.goal",
                value: .newGoal,
                role: .search) {
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
