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
    
    var progressBackgroundColor: ColorModel
    var progressMainColor: ColorModel
    
    init(name: String,
         currentValue: Int,
         goalValue: Int,
         backgroundColor: ColorModel,
         tintColor: ColorModel) {
        self.name = name
        self.currentValue = currentValue
        self.goalValue = goalValue
        self.progressBackgroundColor = backgroundColor
        self.progressMainColor = tintColor
    }
    
    func getProgress() -> Double {
        Double(currentValue) / Double(goalValue)
    }
}
