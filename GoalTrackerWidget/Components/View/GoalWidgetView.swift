//
//  GoalWidgetView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 11/01/2026.
//

import SwiftUI
import WidgetKit

struct GoalWidgetView: View {
    
    var entry: GoalEntry
    
    var body: some View {
        if entry.isPlaceholder {
            goalView()
                .redacted(reason: .placeholder)
        } else {
            goalView()
        }
    }
    
    func goalView() -> some View {
        VStack(alignment: .leading) {
            Text(entry.name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
                .lineLimit(0)
                .foregroundStyle(entry.textColor)
            
            Spacer()
            
            Text(entry.progress, format: .percent.precision(.fractionLength(0)))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.title2.bold())
                .foregroundStyle(entry.textColor)
        }
        .containerBackground(for: .widget){
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    entry.progressColor
                        .frame(width: geometry.size.width * entry.progress)
                    entry.backgroundColor
                }
            }
        }
    }
    
    func roundToLastNonZero(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 12
        formatter.maximumIntegerDigits = 12
        formatter.maximumSignificantDigits = 12
        formatter.usesSignificantDigits = true
        formatter.numberStyle = .decimal
        
        return formatter.string(for: value) ?? "\(value)"
    }
}

#Preview(as: .systemSmall) {
    GoalWidget()
} timeline: {
    GoalEntry(
        date: .now,
        name: "Select Goal",
        progress: 0.5,
        textColor: .black,
        progressColor: .blue,
        backgroundColor: .blue.opacity(0.2),
        isPlaceholder: true
    )
}
