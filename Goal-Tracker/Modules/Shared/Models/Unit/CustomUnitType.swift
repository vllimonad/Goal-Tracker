//
//  CustomUnitType.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 10/01/2026.
//

import Foundation

struct CustomUnitType: Codable {
    
    var name: String
    var abbreviation: String
        
    init(name: String, abbreviation: String) {
        self.name = name
        self.abbreviation = abbreviation
    }
}
