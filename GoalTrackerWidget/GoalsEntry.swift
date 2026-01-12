//
//  GoalEntry.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 11/01/2026.
//

import Foundation
import WidgetKit
import SwiftUI
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
    static var title: LocalizedStringResource = "Select Goal"
    
    @Parameter(title: "Goal")
    var goal: GoalEntity?
}

struct GoalEntry: TimelineEntry {
    let date: Date
    let goal: GoalModel?
    let isPlaceholder: Bool
}

struct GoalProvider: AppIntentTimelineProvider {
    
    func placeholder(in context: Context) -> GoalEntry {
        GoalEntry(date: .now, goal: nil, isPlaceholder: true)
    }

    func snapshot(for configuration: SelectGoalIntent, in context: Context) async -> GoalEntry {
        GoalEntry(
            date: .now,
            goal: GoalModel(
                name: "Goal",
                initialValue: 1,
                targetValue: 2,
                unit: UnitModel(systemType: .currency(.usd)),
                colors: ColorsModel(
                    progress: ColorModel(color: .blue),
                    background: ColorModel(red: 0.90, green: 0.94, blue: 1.0),
                    text: ColorModel(color: .black)
                )
            ),
            isPlaceholder: false
        )
    }
    
    func timeline(for configuration: SelectGoalIntent, in context: Context) async -> Timeline<GoalEntry> {
        guard let selectedGoal = configuration.goal else {
            print("Timeline nil")
            let entry = GoalEntry(date: .now, goal: nil, isPlaceholder: true)
            return Timeline(entries: [entry], policy: .never)
        }
        
        let goalID = selectedGoal.id
        let goal = await getGoalModel(for: goalID)
        
        let entry = GoalEntry(
            date: .now,
            goal: goal,
            isPlaceholder: false
        )
        
        return Timeline(entries: [entry], policy: .never)
    }
    
    @MainActor
    private func getGoalModel(for id: UUID) -> GoalModel? {
        guard let modelContainer = try? ModelContainer(for: GoalModel.self) else { return nil }
        
        let descriptor = FetchDescriptor<GoalModel>(predicate: #Predicate { $0.id == id })
        return try? modelContainer.mainContext.fetch(descriptor).first
    }
}
