//
//  NewGoalView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 27/09/2025.
//

import SwiftUI

struct NewGoalView: View {
    
    @State private var viewModel = NewGoalViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Goal's name", text: $viewModel.name)
                }
                
                Section("Data") {
                    HStack {
                        Text("Initial value")
                        
                        Spacer()
                        
                        TextField("", value: $viewModel.initialValue, formatter: NumberFormatter())
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Goal value")
                        
                        Spacer()
                        
                        TextField("", value: $viewModel.goalValue, formatter: NumberFormatter())
                            .multilineTextAlignment(.trailing)
                    }
                }
                    
                
                    
                    
                    
                
            }
        }
    }
}

#Preview {
    NewGoalView()
}
