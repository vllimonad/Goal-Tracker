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
    var currentValue: Double
    var goalValue: Double
    
    var progressColor: ColorModel
    var backgroundColor: ColorModel
    var textColor: ColorModel
    
    init(name: String,
         currentValue: Double,
         goalValue: Double,
         progressColor: ColorModel,
         backgroundColor: ColorModel,
         textColor: ColorModel) {
        self.name = name
        self.currentValue = currentValue
        self.goalValue = goalValue
        self.progressColor = progressColor
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
    
    func getProgress() -> Double {
        currentValue / goalValue
    }
}
