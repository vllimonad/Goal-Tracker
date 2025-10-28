//
//  GoalProgressView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 26/09/2025.
//

import SwiftUI

struct GoalProgressView: View {
    
    var model: GoalModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(model.name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(model.textColor.color)
            Text("\(roundToLastNonZero(model.currentValue)) / \(roundToLastNonZero(model.targetValue)) \(model.unitType.abbreviation)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(model.textColor.color)
        }
        .padding(16)
        .background {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    model.progressColor.color
                        .frame(width: geometry.size.width * model.getProgress())
                    model.backgroundColor.color
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
    GoalProgressView(model: GoalModel())
}
