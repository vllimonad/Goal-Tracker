//
//  StatsView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 29/09/2025.
//

import SwiftUI

struct StatsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 8) {
                    HStack(spacing: 8) {
                        StatView(name: .constant("ddd"), descritpion: .constant("ddd"), iconResource: .constant(.tabGoals))
                        
                        StatView(name: .constant("ddd"), descritpion: .constant("ddd"), iconResource: .constant(.tabGoals))
                    }
                    
                    HStack(spacing: 8) {
                        StatView(name: .constant("ddd"), descritpion: .constant("ddd"), iconResource: .constant(.tabGoals))
                        
                        StatView(name: .constant("ddd"), descritpion: .constant("ddd"), iconResource: .constant(.tabGoals))
                    }
                }
                .padding(.horizontal, 24)
            }
            .background(Color.bg)
            .navigationTitle("stats.title")
        }
    }
}

#Preview {
    StatsView()
}
