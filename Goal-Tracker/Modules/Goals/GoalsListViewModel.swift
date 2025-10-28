//
//  GoalsListViewModel.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 27/09/2025.
//

import Foundation
import Combine

@MainActor
@Observable
final class GoalsListViewModel {
    
    var models: [GoalModel]
    
    init() {
        self.models = []
    }
    
    func fetchModels() {
        models = GoalStorage.shared.fetchModels()
    }
    
    func deleteModel(_ model: GoalModel) {
        do {
            guard let index = models.firstIndex(of: model) else { return }
            
            try GoalStorage.shared.deleteModel(model)
            models.remove(at: index)
        } catch {
            print(error.localizedDescription)
        }
    }
}
