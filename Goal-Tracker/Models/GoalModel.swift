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
    var initialValue: Double
    var targetValue: Double
    var unitType: UnitType
    
    var progressColor: ColorModel
    var backgroundColor: ColorModel
    var textColor: ColorModel
    
    init(name: String,
         initialValue: Double,
         targetValue: Double,
         unitType: UnitType,
         progressColor: ColorModel,
         backgroundColor: ColorModel,
         textColor: ColorModel) {
        self.name = name
        self.initialValue = initialValue
        self.targetValue = targetValue
        self.unitType = unitType
        self.progressColor = progressColor
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
    
    func getProgress() -> Double {
        initialValue / targetValue
    }
}
