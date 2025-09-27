//
//  ContentView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 09/09/2025.
//

import SwiftUI

struct GoalsListView: View {
    
    @State private var models: [GoalModel] = [
        GoalModel(name: "ggg",
                  currentValue: 12,
                  goalValue: 44,
                  backgroundColor: ColorModel(color: .blue.opacity(0.3)),
                  tintColor: ColorModel(color: .blue.opacity(0.5))),
        GoalModel(name: "ervewr",
                  currentValue: 323,
                  goalValue: 436,
                  backgroundColor: ColorModel(color: .green.opacity(0.3)),
                  tintColor: ColorModel(color: .green.opacity(0.5)))
        ]
    
    var body: some View {
        NavigationView {
            List(models) { model in
                GoalProgressView(model: model)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 0, leading: 24, bottom: 0, trailing: 24))
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                    )
                    .swipeActions(edge: .trailing) {
                        Button("Delete", role: .destructive) {
                            
                        }
                    }
            }
            .listRowSpacing(8)
            .listStyle(.plain)
            .navigationTitle(Text("goals.title"))
        }
    }
}

#Preview {
    GoalsListView()
}
