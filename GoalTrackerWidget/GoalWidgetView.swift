//
//  GoalWidgetView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 11/01/2026.
//

import SwiftUI
import WidgetKit

struct GoalWidgetView: View {
    
    var goal: GoalEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(goal.name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
                .lineLimit(0)
                .foregroundStyle(goal.textColor)
            
            Spacer()
            
            Text(goal.getProgress(), format: .percent.precision(.fractionLength(0)))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.title2.bold())
                .foregroundStyle(goal.textColor)
                .contentTransition(.numericText())
                .animation(.snappy, value: goal.currentValue)
        }
        .containerBackground(for: .widget){
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    goal.progressColor
                        .frame(width: geometry.size.width * goal.getProgress())
                        .animation(.spring, value: goal.getProgress())
                    goal.backgroundColor
                        .animation(.spring, value: goal.getProgress())
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
        name: "Nmaef",
        currentValue: 12,
        targetValue: 123,
        unitAbbreviation: "$",
        date: .now,
        progressColor: .blue,
        backgroundColor: .cyan,
        textColor: .black
    )
}
