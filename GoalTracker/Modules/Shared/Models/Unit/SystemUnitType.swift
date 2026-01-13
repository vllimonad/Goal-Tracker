//
//  UnitType.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 28/09/2025.
//

import Foundation
import SwiftData

enum SystemUnitType: Codable, Hashable {
    
    case weight(WeightUnitType)
    case distance(DistanceUnitType)
    case currency(CurrencyUnitType)
    case other(OtherUnitType)
    
    var name: String {
        switch self {
        case .weight(let value): value.name
        case .distance(let value): value.name
        case .currency(let value): value.name
        case .other(let value): value.name
        }
    }
    
    var abbreviation: String {
        switch self {
        case .weight(let value): value.abbreviation
        case .distance(let value): value.abbreviation
        case .currency(let value): value.abbreviation
        case .other(let value): value.abbreviation
        }
    }
}
