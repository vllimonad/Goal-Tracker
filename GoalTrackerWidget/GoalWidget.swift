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
        StaticConfiguration(kind: kind, provider: GoalTimelineProvider()) { entry in
            GoalWidgetView(goal: entry)
        }
        .configurationDisplayName("Vertical progress")
        .supportedFamilies([.systemSmall])
    }
}
