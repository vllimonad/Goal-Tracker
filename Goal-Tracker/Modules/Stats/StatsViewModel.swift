//
//  StatsViewModel.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 08/10/2025.
//

import Foundation

@MainActor
@Observable
final class StatsViewModel {
    
    var goals: [GoalModel]
    var records: [RecordModel]
    
    var totalGoals: Int { goals.count }
    var activeGoals: Int { goals.filter(\.isActive).count }
    var averageProgress: Double {
        goals.reduce(0) { $0 + $1.getProgress() } / Double(goals.count) * 100
    }
    
    init() {
        self.goals = []
        self.records = []
    }
    
    func fetchModels() {
        self.goals = GoalStorage.shared.fetchModels()
    }
}
