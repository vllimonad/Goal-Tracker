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
                .foregroundStyle(model.textColor.getColor())
            Text("\(roundToLastNonZero(model.initialValue))/\(roundToLastNonZero(model.targetValue)) \(model.unitType.abbreviation)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(model.textColor.getColor())
        }
        .padding(16)
        .background {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    model.progressColor.getColor()
                        .frame(width: geometry.size.width * model.getProgress())
                    model.backgroundColor.getColor()
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
    GoalProgressView(model: GoalModel(name: "ggg",
                                      initialValue: 24564356.7,
                                      targetValue: 44,
                                      unitType: .currency(.eur),
                                      progressColor: ColorModel(color: .blue.opacity(0.3)),
                                      backgroundColor: ColorModel(color: .blue.opacity(0.5)),
                                      textColor: .init(color: .black)))
}
