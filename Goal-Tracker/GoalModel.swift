//
//  GoalModel.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 26/09/2025.
//

import Foundation
import SwiftData

@Model
class GoalModel {
    
    var name: String
    var currentValue: Int
    var goalValue: Int
    
    init(name: String, currentValue: Int, goalValue: Int) {
        self.name = name
        self.currentValue = currentValue
        self.goalValue = goalValue
    }
    
    func getProgress() -> Double {
        Double(currentValue) / Double(goalValue)
    }
}
