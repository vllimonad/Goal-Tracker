//
//  GoalsListViewModel.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 27/09/2025.
//

import Foundation
import Combine

@Observable
final class GoalsListViewModel {
    
    var models: [GoalModel]
    
    init(models: [GoalModel]) {
        self.models = [GoalModel(), GoalModel()]
    }
    
    func deleteModel(_ model: GoalModel) {
        guard let index = models.firstIndex(of: model) else { return }
        
        models.remove(at: index)
    }
}
