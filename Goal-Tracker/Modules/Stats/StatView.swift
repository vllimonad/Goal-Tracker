//
//  StatView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 29/09/2025.
//

import SwiftUI

struct StatView: View {
    
    var name: String
    var value: String
    var iconResource: ImageResource
    
    var body: some View {
        HStack(spacing: 12) {
            Image(iconResource)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Text(value)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.body)
                    .foregroundStyle(.primary)
            }
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
        }
        .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 0)
    }
}

#Preview {
    StatView(name: "dddsfvgfs", value: "ddd", iconResource: .tabGoals)
        .background(.black)
}
