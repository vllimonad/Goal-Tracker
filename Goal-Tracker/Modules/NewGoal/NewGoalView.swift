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
                        
                        TextField("", value: $viewModel.targetValue, formatter: NumberFormatter())
                            .multilineTextAlignment(.trailing)
                    }
                    
                    NavigationLink {
                        UnitPickerView(unit: $viewModel.unitType)
                    } label: {
                        HStack {
                            Text("Unit")
                            
                            Spacer()
                            
                            Text(viewModel.unitType.name)
                        }
                    }
                }
                
                Section("Colors") {
                    ColorPicker("Progress",
                                selection: $viewModel.progressColor,
                                supportsOpacity: false)
                    ColorPicker("Background",
                                selection: $viewModel.backgroundColor,
                                supportsOpacity: false)
                    ColorPicker("Text",
                                selection: $viewModel.textColor,
                                supportsOpacity: false)
                }
                
                Section("Preview") {
                    GoalProgressView(model: viewModel.getModel())
                        .listRowInsets(EdgeInsets())
                }
            }
        }
    }
}

#Preview {
    NewGoalView()
}
