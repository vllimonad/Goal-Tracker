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
        self.models = [
            GoalModel(name: "ggg",
                      currentValue: 12,
                      goalValue: 44,
                      backgroundColor: ColorModel(color: .blue.opacity(0.3)),
                      tintColor: ColorModel(color: .blue.opacity(0.5))),
            GoalModel(name: "ervewr",
                      currentValue: 323,
                      goalValue: 436,
                      backgroundColor: ColorModel(color: .green.opacity(0.3)),
                      tintColor: ColorModel(color: .green.opacity(0.5)))
            ]
    }
    
    func deleteModel(_ model: GoalModel) {
        guard let index = models.firstIndex(of: model) else { return }
        
        models.remove(at: index)
    }
}
