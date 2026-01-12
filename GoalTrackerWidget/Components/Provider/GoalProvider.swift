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

struct GoalProvider: AppIntentTimelineProvider {
    
    let placeholderEntry = GoalEntry(
        date: .now,
        name: "Selected goal",
        progress: 0.5,
        textColor: .black,
        progressColor: .blue,
        backgroundColor: Color(red: 0.90, green: 0.94, blue: 1.0),
        isPlaceholder: true
    )
    
    let snapshotEntry = GoalEntry(
        date: .now,
        name: "Journeys",
        progress: 0.3,
        textColor: .black,
        progressColor: .orange,
        backgroundColor: Color(red: 1.0, green: 0.95, blue: 0.90),
        isPlaceholder: false
    )
    
    func placeholder(in context: Context) -> GoalEntry {
        placeholderEntry
    }

    func snapshot(for configuration: SelectGoalIntent, in context: Context) async -> GoalEntry {
        snapshotEntry
    }
    
    func timeline(for configuration: SelectGoalIntent, in context: Context) async -> Timeline<GoalEntry> {
        if let selectedGoal = configuration.goal, let entry = await getGoalEntry(for: selectedGoal.id) {
            return Timeline(entries: [entry], policy: .never)
        } else {
            return Timeline(entries: [placeholderEntry], policy: .never)
        }
    }
    
    @MainActor
    private func getGoalEntry(for id: UUID) -> GoalEntry? {
        guard let modelContainer = try? ModelContainer(for: GoalModel.self) else { return nil }
        
        let descriptor = FetchDescriptor<GoalModel>(predicate: #Predicate { $0.id == id })
        guard let goal = try? modelContainer.mainContext.fetch(descriptor).first else { return nil }
        
        return GoalEntry (
            date: .now,
            name: goal.name,
            progress: goal.getProgress(),
            textColor: goal.colors.text.color,
            progressColor: goal.colors.progress.color,
            backgroundColor: goal.colors.background.color,
            isPlaceholder: false
        )
    }
}
