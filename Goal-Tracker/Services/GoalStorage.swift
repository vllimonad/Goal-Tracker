//
//  GoalStorage.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 29/09/2025.
//

import SwiftData
import Foundation

@MainActor
final class GoalStorage {
    
    static let shared = GoalStorage()
    
    private let modelContainer: ModelContainer
    
    init(modelContainer: ModelContainer? = nil) {
        if let modelContainer {
            self.modelContainer = modelContainer
        } else {
            do {
                self.modelContainer = try ModelContainer(for: GoalModel.self)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func fetchModels() -> [GoalModel] {
        let sortDescriptor = SortDescriptor<GoalModel>(\.creationDate, order: .reverse)
        let fetchDescriptor = FetchDescriptor(sortBy: [sortDescriptor])
        
        return (try? modelContainer.mainContext.fetch(fetchDescriptor)) ?? []
    }
    
    func insertModel(_ model: GoalModel) throws {
        modelContainer.mainContext.insert(model)
        try saveContext()
    }
    
    func deleteModel(_ model: GoalModel) throws {
        modelContainer.mainContext.delete(model)
        try saveContext()
    }
    
    private func saveContext() throws {
        try modelContainer.mainContext.save()
    }
}
