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
                      initialValue: 12,
                      targetValue: 44,
                      unitType: .currency(.eur),
                      progressColor: ColorModel(color: .blue.opacity(0.3)),
                      backgroundColor: ColorModel(color: .blue.opacity(0.5)),
                      textColor: .init(color: .black)),
            GoalModel(name: "ggg",
                      initialValue: 12,
                      targetValue: 44,
                      unitType: .currency(.eur),
                      progressColor: ColorModel(color: .blue.opacity(0.3)),
                      backgroundColor: ColorModel(color: .blue.opacity(0.5)),
                      textColor: .init(color: .black))
            ]
    }
    
    func deleteModel(_ model: GoalModel) {
        guard let index = models.firstIndex(of: model) else { return }
        
        models.remove(at: index)
    }
}
