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
        if let goal = entry.goal {
            goalView(goal: goal)
        } else {
            goalView(goal: GoalModel(
                name: "Goal",
                initialValue: 1,
                targetValue: 2,
                unit: UnitModel(systemType: .currency(.usd)),
                colors: ColorsModel(
                    progress: ColorModel(color: .blue),
                    background: ColorModel(red: 0.90, green: 0.94, blue: 1.0),
                    text: ColorModel(color: .black)
                )
            ))
            .redacted(reason: .placeholder)
        }
    }
    
    func goalView(goal: GoalModel) -> some View {
        VStack(alignment: .leading) {
            Text(goal.name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
                .lineLimit(0)
                .foregroundStyle(goal.colors.text.color)
            
            Spacer()
            
            Text(goal.getProgress(), format: .percent.precision(.fractionLength(0)))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.title2.bold())
                .foregroundStyle(goal.colors.text.color)
                .contentTransition(.numericText())
                .animation(.snappy, value: goal.currentValue)
        }
        .containerBackground(for: .widget){
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    goal.colors.progress.color
                        .frame(width: geometry.size.width * goal.getProgress())
                        .animation(.spring, value: goal.getProgress())
                    goal.colors.background.color
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
