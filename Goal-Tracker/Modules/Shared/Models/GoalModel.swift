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
    
    var id: UUID
    var name: String
    var creationDate: Date
    
    var initialValue: Double
    var targetValue: Double
    var unitType: UnitType
    var isArchived: Bool
    var isDeleted: Bool
    
    var colors: ColorsModel
    
    @Relationship(deleteRule: .cascade) var records: [RecordModel]
    
    var currentValue: Double {
        records.reduce(initialValue) { $0 + $1.value }
    }
    
    var isCompleted: Bool {
        currentValue >= targetValue
    }
    
    var valuesHistory: [RecordModel] {
        var totalPerRecord = initialValue
        
        var history = records.map {
            totalPerRecord += $0.value
            return RecordModel(id: UUID(), date: $0.date, value: totalPerRecord)
        }
        
        history.insert(RecordModel(
            id: UUID(),
            date: creationDate,
            value: initialValue),
                       at: 0
        )
        
        return history
    }
    
    convenience init(
        name: String,
        initialValue: Double,
        targetValue: Double,
        unitType: UnitType,
        colors: ColorsModel
    ) {
        self.init(
            id: UUID(),
            name: name,
            creationDate: .now,
            initialValue: initialValue,
            targetValue: targetValue,
            unitType: unitType,
            isArchived: false,
            isDeleted: false,
            colors: colors,
            records: []
        )
    }
    
    init(
        id: UUID,
        name: String,
        creationDate: Date,
        initialValue: Double,
        targetValue: Double,
        unitType: UnitType,
        isArchived: Bool,
        isDeleted: Bool,
        colors: ColorsModel,
        records: [RecordModel]
    ) {
        self.id = id
        self.name = name
        self.creationDate = creationDate
        self.initialValue = initialValue
        self.targetValue = targetValue
        self.unitType = unitType
        self.isDeleted = isDeleted
        self.isArchived = isArchived
        self.colors = colors
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
