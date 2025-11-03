//
//  GoalProgressView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 26/09/2025.
//

import SwiftUI

struct GoalProgressView: View {
    
    var goal: GoalModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(goal.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .foregroundStyle(goal.colors.text.color)
                
                Text("\(roundToLastNonZero(goal.currentValue)) / \(roundToLastNonZero(goal.targetValue)) \(goal.unitType.abbreviation)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                    .foregroundStyle(goal.colors.text.color)
            }
            
            Text(goal.getProgress(), format: .percent.rounded(increment: 0.1))
                .font(.subheadline)
                .foregroundStyle(goal.colors.text.color)
        }
        .padding(16)
        .background {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    goal.colors.progress.color
                        .frame(width: geometry.size.width * goal.getProgress())
                    goal.colors.background.color
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
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

#Preview {
    GoalProgressView(goal: GoalModel(
        name: "A",
        initialValue: 0,
        targetValue: 0,
        unitType: .currency(.eur),
        colors: ColorsModel()
    ))
}
