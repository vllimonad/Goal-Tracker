//
//  ContentView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 09/09/2025.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<5) { _ in
                    GoalProgressView(model: .constant(GoalModel(name: "ggg",
                                                                currentValue: 12,
                                                                goalValue: 44,
                                                                backgroundColor: ColorModel(color: .blue.opacity(0.3)),
                                                                tintColor: ColorModel(color: .blue.opacity(0.5)))))
                }
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    ContentView()
}
