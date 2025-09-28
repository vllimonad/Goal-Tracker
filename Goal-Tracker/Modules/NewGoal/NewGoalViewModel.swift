//
//  NewGoalViewModel.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 28/09/2025.
//

import Foundation
import SwiftUI

@Observable
final class NewGoalViewModel {
    
    var name: String
    var initialValue: Double
    var goalValue: Double
    var unit: UnitType
    var progressColor: Color
    var backgroundColor: Color
    
    init() {
        self.name = ""
        self.initialValue = 0
        self.goalValue = 0
        self.unit = .other(.none)
        self.progressColor = .blue.opacity(0.7)
        self.backgroundColor = .blue.opacity(0.4)
    }
    
    func getModel() -> GoalModel {
        GoalModel(name: name,
                  currentValue: initialValue,
                  goalValue: goalValue,
                  progressColor: .init(color: progressColor),
                  backgroundColor: .init(color: backgroundColor))
    }
}
