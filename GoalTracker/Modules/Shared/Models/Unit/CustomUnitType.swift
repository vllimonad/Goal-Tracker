//
//  UnitModel.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 10/01/2026.
//

import Foundation
import SwiftData

@Model
class CustomUnitType {
    
    var id: UUID
    var name: String
    var abbreviation: String
    var sortIndex: Int = 0
    var creationDate: Date = Date()
    
    convenience init(name: String, abbreviation: String) {
        self.init(id: UUID(), name: name, abbreviation: abbreviation, sortIndex: 0, creationDate: Date())
    }
    
    init(id: UUID, name: String, abbreviation: String, sortIndex: Int, creationDate: Date) {
        self.id = id
        self.name = name
        self.abbreviation = abbreviation
        self.sortIndex = sortIndex
        self.creationDate = creationDate
    }
}
