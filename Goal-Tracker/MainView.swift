//
//  MainView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 27/09/2025.
//

import SwiftUI

struct MainView: View {
    
    @State private var selectedTab: TabType = .goals
    
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
            
            Tab("new.goal.title", image: "tab.new.goal", value: .newGoal, role: .search) {
                GoalsListView()
            }
        }
        .tint(.primaryBlue)
    }
}

enum TabType {
    case goals, stats, newGoal
}

#Preview {
    MainView()
}
