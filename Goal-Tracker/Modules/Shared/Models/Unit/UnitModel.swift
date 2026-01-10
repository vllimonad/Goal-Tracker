//
//  UnitModel.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 10/01/2026.
//

import Foundation
import SwiftData

@Model
class UnitModel {
    
    private(set) var type: UnitType
    
    @Relationship(deleteRule: .deny) private(set) var customType: CustomUnitType?
    
    private(set) var systemType: SystemUnitType?
    
    var name: String {
        switch type {
        case .custom:
            return customType!.name
        case .system:
            return systemType!.name
        }
    }
    
    var abbreviation: String {
        switch type {
        case .custom:
            return customType!.abbreviation
        case .system:
            return systemType!.abbreviation
        }
    }
    
    convenience init(customType: CustomUnitType) {
        self.init(type: .custom, customType: customType, systemType: nil)
    }
    
    convenience init(systemType: SystemUnitType) {
        self.init(type: .system, customType: nil, systemType: systemType)
    }
    
    private init(
        type: UnitType,
        customType: CustomUnitType?,
        systemType: SystemUnitType?
    ) {
        self.type = type
        self.customType = customType
        self.systemType = systemType
    }
}
