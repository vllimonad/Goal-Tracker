//
//  NewGoalViewModel.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 28/09/2025.
//

import Foundation

@Observable
final class NewGoalViewModel {
    
    var name: String
    var initialValue: Double
    var goalValue: Double
    var unit: UnitType
    
    init() {
        self.name = ""
        self.initialValue = 0
        self.goalValue = 0
        self.unit = .none
    }
}
