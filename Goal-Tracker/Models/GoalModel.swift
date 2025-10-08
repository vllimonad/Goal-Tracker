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
    
    @Relationship(deleteRule: .cascade) var records: [RecordModel]
    
    var currentValue: Double {
        records.reduce(0) { $0 + $1.value }
    }
    
    var isActive: Bool {
        currentValue < targetValue
    }
    
    convenience init() {
        self.init(name: "",
                  creationDate: .now,
                  initialValue: 0,
                  targetValue: 0,
                  unitType: .other(.none),
                  progressColor: ColorModel(color: .blue.opacity(0.7)),
                  backgroundColor: ColorModel(color: .blue.opacity(0.4)),
                  textColor: ColorModel(color: .black),
                  records: [])
    }
    
    init(name: String,
         creationDate: Date,
         initialValue: Double,
         targetValue: Double,
         unitType: UnitType,
         progressColor: ColorModel,
         backgroundColor: ColorModel,
         textColor: ColorModel,
         records: [RecordModel]) {
        self.name = name
        self.creationDate = creationDate
        self.initialValue = initialValue
        self.targetValue = targetValue
        self.unitType = unitType
        self.progressColor = progressColor
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.records = records
    }
    
    func getProgress() -> Double {
        guard targetValue != 0 else {
            return 0.5
        }
        
        let progress = currentValue / targetValue
        
        if progress.isInfinite {
            return 0.5
        } else if progress < 0 {
            return 0
        } else {
            return progress
        }
    }
}
