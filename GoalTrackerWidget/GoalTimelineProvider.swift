//
//  GoalTimelineProvider.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 11/01/2026.
//

import Foundation
import WidgetKit
import SwiftUI

struct GoalTimelineProvider: TimelineProvider {
    
    func placeholder(in context: Context) -> GoalEntry {
        GoalEntry(
            name: "Goal name",
            currentValue: 50,
            targetValue: 100,
            unitAbbreviation: "$",
            date: .now,
            progressColor: .blue,
            backgroundColor: Color(red: 0.9, green: 0.94, blue: 1.0),
            textColor: .black
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (GoalEntry) -> Void) {
        let entry = GoalEntry(
            name: "Nmaef",
            currentValue: 12,
            targetValue: 123,
            unitAbbreviation: "$",
            date: .now,
            progressColor: .red,
            backgroundColor: .gray,
            textColor: .blue
        )
        
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<GoalEntry>) -> Void) {
        let entry = GoalEntry(
            name: "Nmaef",
            currentValue: 12,
            targetValue: 123,
            unitAbbreviation: "$",
            date: .now,
            progressColor: .red,
            backgroundColor: .gray,
            textColor: .blue
        )

        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}
