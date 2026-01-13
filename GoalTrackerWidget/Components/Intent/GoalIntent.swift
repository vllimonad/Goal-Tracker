//
//  GoalEntity.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 12/01/2026.
//

import Foundation
import WidgetKit
import AppIntents
import SwiftData

struct GoalEntity: AppEntity {
    let id: UUID
    let name: String

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Goal"
    static var defaultQuery = GoalQuery()

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(name)")
    }
}

struct GoalQuery: EntityQuery {
    
    @MainActor
    func entities(for identifiers: [UUID]) async throws -> [GoalEntity] {
        guard let modelContainer = try? ModelContainer(for: GoalModel.self) else { return [] }
        
        let fetchDescriptor = FetchDescriptor<GoalModel>(predicate: #Predicate { identifiers.contains($0.id) })
        
        guard let models = try? modelContainer.mainContext.fetch(fetchDescriptor) else { return [] }
        
        return models.map { GoalEntity(id: $0.id, name: $0.name) }
    }

    @MainActor
    func suggestedEntities() async throws -> [GoalEntity] {
        guard let modelContainer = try? ModelContainer(for: GoalModel.self) else { return [] }
        
        let fetchDescriptor = FetchDescriptor<GoalModel>(sortBy: [SortDescriptor(\.creationDate)])
        
        guard let models = try? modelContainer.mainContext.fetch(fetchDescriptor) else { return [] }
        
        return models.map { GoalEntity(id: $0.id, name: $0.name) }
    }
}

struct SelectGoalIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "widget.goal.selection.title"
    
    @Parameter(title: "widget.goal.parameter.title")
    var goal: GoalEntity?
}
