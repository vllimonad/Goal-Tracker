//
//  UnitType.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 28/09/2025.
//

import Foundation

enum UnitType: Codable, Hashable {
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

enum CurrencyUnitType: CaseIterable, Codable {
    case usd, eur, pln, jpy, gbp
    
    var name: String {
        switch self {
        case .usd: String(localized: "unit.currency.usd.name")
        case .eur: String(localized: "unit.currency.eur.name")
        case .pln: String(localized: "unit.currency.pln.name")
        case .jpy: String(localized: "unit.currency.jpy.name")
        case .gbp: String(localized: "unit.currency.gbp.name")
        }
    }
    
    var abbreviation: String {
        switch self {
        case .usd: String(localized: "unit.currency.usd.abbreviation")
        case .eur: String(localized: "unit.currency.eur.abbreviation")
        case .pln: String(localized: "unit.currency.pln.abbreviation")
        case .jpy: String(localized: "unit.currency.jpy.abbreviation")
        case .gbp: String(localized: "unit.currency.gbp.abbreviation")
        }
    }
}

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

