//
//  GoalEntry.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 11/01/2026.
//

import Foundation
import WidgetKit
import SwiftUI

struct GoalEntry: TimelineEntry {
    
    let name: String
    let currentValue: Double
    let targetValue: Double
    let unitAbbreviation: String
    let date: Date
    
    let progressColor: Color
    let backgroundColor: Color
    let textColor: Color
    
    func getProgress() -> Double {
        guard targetValue != 0 else {
            return 0.5
        }
        
        let progress = currentValue / targetValue
        
        if progress.isInfinite {
            return 0.5
        } else if progress < 0 {
            return 0
        } else {
            return progress
        }
    }
}
