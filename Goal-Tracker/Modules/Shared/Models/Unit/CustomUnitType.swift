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
    
    convenience init(name: String, abbreviation: String) {
        self.init(id: UUID(), name: name, abbreviation: abbreviation)
    }
    
    init(id: UUID, name: String, abbreviation: String) {
        self.id = id
        self.name = name
        self.abbreviation = abbreviation
    }
}
