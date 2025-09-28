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
            Text("\(model.currentValue)/\(model.goalValue) ML")
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
}

#Preview {
    GoalProgressView(model: GoalModel(name: "ggg",
                                      currentValue: 12,
                                      goalValue: 44,
                                      progressColor: ColorModel(color: .blue.opacity(0.3)),
                                      backgroundColor: ColorModel(color: .blue.opacity(0.5)),
                                      textColor: .init(color: .black)))
}
