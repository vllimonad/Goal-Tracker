//
//  ContentView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 09/09/2025.
//

import SwiftUI

struct GoalsListView: View {
    
    @State private var viewModel = GoalsListViewModel(models: [])
    
    var body: some View {
        NavigationView {
            List(viewModel.models) { model in
                GoalProgressView(model: model)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 0, leading: 24, bottom: 0, trailing: 24))
                    .listRowBackground(Color.white)
                    .swipeActions(edge: .trailing) {
                        Button("Delete", role: .destructive) {
                            viewModel.deleteModel(model)
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
