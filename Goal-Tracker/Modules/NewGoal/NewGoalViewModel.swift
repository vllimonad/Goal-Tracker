//
//  NewGoalViewModel.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 28/09/2025.
//

import Foundation
import SwiftUI

@Observable
final class NewGoalViewModel {
    
    private let storage: NewGoalStorageProtocol
    
    var model: GoalModel
    
    init(storage: NewGoalStorageProtocol) {
        self.storage = storage
        self.model = GoalModel()
    }
    
    func saveModel() {
        
    }
}
