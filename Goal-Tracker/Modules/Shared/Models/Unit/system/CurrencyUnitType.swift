//
//  CurrencyUnitType.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 10/01/2026.
//

import Foundation

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
