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
    var creationDate: Date
    
    var initialValue: Double
    var targetValue: Double
    var unitType: UnitType
    
    var progressColor: ColorModel
    var backgroundColor: ColorModel
    var textColor: ColorModel
    
    convenience init() {
        self.init(name: "",
                  creationDate: .now,
                  initialValue: 0,
                  targetValue: 0,
                  unitType: .other(.none),
                  progressColor: ColorModel(color: .blue.opacity(0.7)),
                  backgroundColor: ColorModel(color: .blue.opacity(0.4)),
                  textColor: ColorModel(color: .black))
    }
    
    init(name: String,
         creationDate: Date,
         initialValue: Double,
         targetValue: Double,
         unitType: UnitType,
         progressColor: ColorModel,
         backgroundColor: ColorModel,
         textColor: ColorModel) {
        self.name = name
        self.creationDate = creationDate
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
