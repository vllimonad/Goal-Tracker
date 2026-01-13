//
//  RecordModel.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 08/10/2025.
//

import Foundation
import SwiftData

@Model
class RecordModel {
    
    var id: UUID
    var date: Date
    var value: Double
    
    convenience init(value: Double) {
        self.init(id: UUID(), date: .now, value: value)
    }
    
    init(id: UUID, date: Date, value: Double) {
        self.id = id
        self.date = date
        self.value = value
    }
    
}
