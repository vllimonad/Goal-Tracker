//
//  ColorPreset.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 02/11/2025.
//

import SwiftUI

struct ColorsPreset: View {
    
    var colorsModel: ColorsModel
    
    var body: some View {
        HStack(spacing: 0) {
            colorsModel.background.color
            colorsModel.progress.color
        }
        .frame(width: 50, height: 30)
        .clipShape(Capsule())
    }
}

#Preview {
    ColorsPreset(colorsModel: ColorsModel())
}
