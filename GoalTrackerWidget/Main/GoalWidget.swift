//
//  GoalWidget.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 11/01/2026.
//

import Foundation

import WidgetKit
import SwiftUI

struct GoalWidget: Widget {
    let kind: String = "GoalWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: SelectGoalIntent.self,
            provider: GoalProvider()
        ) { entry in
            GoalWidgetView(entry: entry)
        }
        .configurationDisplayName("Select a goal")
        .description("Track a specific goal on your home screen")
        .supportedFamilies([.systemSmall])
    }
}
