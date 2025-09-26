//
//  GoalProgressView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 26/09/2025.
//

import SwiftUI

struct GoalProgressView: View {
    
    @Binding var model: GoalModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(model.name)
            Text("\(model.currentValue)/\(model.goalValue) ML")
        }
        .padding(16)
        .background {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    model.progressMainColor.getColor()
                        .frame(width: geometry.size.width * model.getProgress())
                    model.progressBackgroundColor.getColor()
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    GoalProgressView(model: .constant(GoalModel(name: "ggg",
                                                currentValue: 12,
                                                goalValue: 44,
                                                backgroundColor: ColorModel(color: .blue.opacity(0.3)),
                                                tintColor: ColorModel(color: .blue.opacity(0.5)))))
}
