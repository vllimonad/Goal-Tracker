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
}

enum WeightUnitType: CaseIterable, Codable {
    case g
    case kg
    case t
    case oz
    case lb
    
    var name: String {
        switch self {
        case .g: "Grams"
        case .kg: "Kilograms"
        case .t: "Tons"
        case .oz: "Ounces"
        case .lb: "Pounds"
        }
    }
}

enum DistanceUnitType: CaseIterable, Codable {
    case mm
    case cm
    case m
    case km
    case inch
    case ft
    case yd
    case mi
    
    var name: String {
        switch self {
        case .mm: "Millimeters"
        case .cm: "Centimeters"
        case .m: "Meters"
        case .km: "Kilometers"
        case .inch: "Inches"
        case .ft: "Feet"
        case .yd: "Yards"
        case .mi: "Miles"
        }
    }
}

enum CurrencyUnitType: CaseIterable, Codable {
    case usd
    case eur
    case pln
    case jpy
    case gbp
    
    var name: String {
        switch self {
        case .usd: "$"
        case .eur: "€"
        case .pln: "zł"
        case .jpy: "¥"
        case .gbp: "£"
        }
    }
}

enum OtherUnitType: CaseIterable, Codable {
    case none
    
    var name: String {
        switch self {
        case .none: "None"
        }
    }
}

