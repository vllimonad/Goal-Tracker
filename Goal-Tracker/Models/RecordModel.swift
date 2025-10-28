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
    
    var date: Date
    var value: Double
    
    convenience init(value: Double) {
        self.init(date: .now, value: value)
    }
    
    init(date: Date, value: Double) {
        self.date = date
        self.value = value
    }
    
}
