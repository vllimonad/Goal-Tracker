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
    var targetValue: Double
    var unitType: UnitType
    
    var progressColor: Color
    var backgroundColor: Color
    var textColor: Color
    
    init() {
        self.name = ""
        self.initialValue = 0
        self.targetValue = 0
        self.unitType = .other(.none)
        
        self.progressColor = .blue.opacity(0.7)
        self.backgroundColor = .blue.opacity(0.4)
        self.textColor = .black
    }
    
    func getModel() -> GoalModel {
        GoalModel(name: name,
                  initialValue: initialValue,
                  targetValue: targetValue,
                  unitType: unitType,
                  progressColor: .init(color: progressColor),
                  backgroundColor: .init(color: backgroundColor),
                  textColor: .init(color: textColor))
    }
    
    func saveModel() {
        
    }
}
