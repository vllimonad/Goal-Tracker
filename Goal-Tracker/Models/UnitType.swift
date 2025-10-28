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
    
    var abbreviation: String {
        switch self {
        case .g: "g"
        case .kg: "kg"
        case .t: "t"
        case .oz: "oz"
        case .lb: "lb"
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
    
    var abbreviation: String {
        switch self {
        case .mm: "mm"
        case .cm: "cm"
        case .m: "m"
        case .km: "km"
        case .inch: "inch"
        case .ft: "ft"
        case .yd: "yd"
        case .mi: "mi"
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
        case .usd: "USD"
        case .eur: "EUR"
        case .pln: "PLN"
        case .jpy: "JPY"
        case .gbp: "GBP"
        }
    }
    
    var abbreviation: String {
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
    
    var abbreviation: String {
        switch self {
        case .none: ""
        }
    }
}

