//
//  GoalEntry.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 12/01/2026.
//

import Foundation
import SwiftUI
import WidgetKit

struct GoalEntry: TimelineEntry {
    let date: Date
    let name: String
    let progress: Double
    let textColor: Color
    let progressColor: Color
    let backgroundColor: Color
    let isPlaceholder: Bool
}
