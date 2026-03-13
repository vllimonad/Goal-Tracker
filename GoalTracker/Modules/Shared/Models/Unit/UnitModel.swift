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
    
    @Relationship(deleteRule: .nullify) private(set) var customType: CustomUnitType?
    
    private(set) var systemType: SystemUnitType?
    
    var name: String {
        let name: String?
        
        switch type {
        case .custom:
            name = customType?.name
        case .system:
            name = systemType?.name
        }
        
        return name ?? SystemUnitType.other(.none).name
    }
    
    var abbreviation: String {
        let abbreviation: String?
        
        switch type {
        case .custom:
            abbreviation = customType?.abbreviation
        case .system:
            abbreviation = systemType?.abbreviation
        }
        
        return abbreviation ?? SystemUnitType.other(.none).abbreviation
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
