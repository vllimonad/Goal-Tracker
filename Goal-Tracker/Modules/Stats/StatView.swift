//
//  StatView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 29/09/2025.
//

import SwiftUI

struct StatView: View {
    
    @Binding var name: String
    @Binding var descritpion: String
    @Binding var iconResource: ImageResource
    
    var body: some View {
        HStack(spacing: 12) {
            Image(iconResource)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Text(descritpion)
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
    StatView(name: .constant("dddsfvgfs"), descritpion: .constant("ddd"), iconResource: .constant(.tabGoals))
        .background(.black)
}
