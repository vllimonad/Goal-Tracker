//
//  StatView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 29/09/2025.
//

import SwiftUI

struct SingleValueStatsView: View {
    
    var title: LocalizedStringKey
    var value: String
    var iconResource: ImageResource
    
    var body: some View {
        HStack(spacing: 12) {
            Image(iconResource)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                    .foregroundStyle(.textSecondary)
                
                Text(value)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.body)
                    .foregroundStyle(.textPrimary)
            }
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.bgPrimary)
        }
        .systemShadow()
    }
}

#Preview {
    SingleValueStatsView(
        title: "dddsfvgfs",
        value: "34.0",
        iconResource: .tabGoals
    )
    .background(.black)
}
