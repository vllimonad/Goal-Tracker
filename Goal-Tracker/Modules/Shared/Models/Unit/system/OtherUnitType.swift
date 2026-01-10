//
//  OtherUnitType.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 10/01/2026.
//

import Foundation

enum OtherUnitType: CaseIterable, Codable {
    case none
    
    var name: String {
        switch self {
        case .none: String(localized: "unit.other.none.name")
        }
    }
    
    var abbreviation: String {
        switch self {
        case .none: String(localized: "unit.other.none.abbreviation")
        }
    }
}
