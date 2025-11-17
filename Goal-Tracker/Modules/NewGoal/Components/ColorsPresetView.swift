//
//  ColorPreset.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 02/11/2025.
//

import SwiftUI

struct ColorsPresetView: View {
    
    var colorsModel: ColorsModel
    var isSelected: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            colorsModel.background.color
            colorsModel.progress.color
        }
        .frame(width: 50, height: 30)
        .clipShape(
            Capsule()
        )
        .padding(4)
        .overlay {
            Capsule()
                .stroke(
                    isSelected ? Color.strokePrimary : Color.clear,
                    lineWidth: 2
                )
        }
    }
}

#Preview {
    ColorsPresetView(colorsModel: ColorsModel(), isSelected: true)
}
