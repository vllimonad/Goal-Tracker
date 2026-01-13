//
//  WeightUnitType.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 10/01/2026.
//

import Foundation

enum WeightUnitType: CaseIterable, Codable {
    case g, kg, t, oz, lb
    
    var name: String {
        switch self {
        case .g:  String(localized: "unit.weight.g.name")
        case .kg: String(localized: "unit.weight.kg.name")
        case .t:  String(localized: "unit.weight.t.name")
        case .oz: String(localized: "unit.weight.oz.name")
        case .lb: String(localized: "unit.weight.lb.name")
        }
    }
    
    var abbreviation: String {
        switch self {
        case .g:  String(localized: "unit.weight.g.abbreviation")
        case .kg: String(localized: "unit.weight.kg.abbreviation")
        case .t:  String(localized: "unit.weight.t.abbreviation")
        case .oz: String(localized: "unit.weight.oz.abbreviation")
        case .lb: String(localized: "unit.weight.lb.abbreviation")
        }
    }
}
