//
//  NewGoalViewModel.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 28/09/2025.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class NewGoalViewModel {
    
    var model: GoalModel
    
    init() {
        self.model = GoalModel()
    }
    
    func saveModel() {
        do {
            try GoalStorage.shared.insertModel(model)
        } catch {
            print(error.localizedDescription)
        }
    }
}
