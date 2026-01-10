//
//  DistanceUnitType.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 10/01/2026.
//

import Foundation

enum DistanceUnitType: CaseIterable, Codable {
    case mm, cm, m, km, inch, ft, yd, mi
    
    var name: String {
        switch self {
        case .mm:   String(localized: "unit.distance.mm.name")
        case .cm:   String(localized: "unit.distance.cm.name")
        case .m:    String(localized: "unit.distance.m.name")
        case .km:   String(localized: "unit.distance.km.name")
        case .inch: String(localized: "unit.distance.inch.name")
        case .ft:   String(localized: "unit.distance.ft.name")
        case .yd:   String(localized: "unit.distance.yd.name")
        case .mi:   String(localized: "unit.distance.mi.name")
        }
    }
    
    var abbreviation: String {
        switch self {
        case .mm:   String(localized: "unit.distance.mm.abbreviation")
        case .cm:   String(localized: "unit.distance.cm.abbreviation")
        case .m:    String(localized: "unit.distance.m.abbreviation")
        case .km:   String(localized: "unit.distance.km.abbreviation")
        case .inch: String(localized: "unit.distance.inch.abbreviation")
        case .ft:   String(localized: "unit.distance.ft.abbreviation")
        case .yd:   String(localized: "unit.distance.yd.abbreviation")
        case .mi:   String(localized: "unit.distance.mi.abbreviation")
        }
    }
}
