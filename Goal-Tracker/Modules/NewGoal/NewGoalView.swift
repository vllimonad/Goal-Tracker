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
                    TextField("goal.name.placeholder", text: $viewModel.name)
                }
                
                Section("goal.data.section.title") {
                    HStack {
                        Text("goal.initial.value")
                        
                        Spacer()
                        
                        TextField("",
                                  value: $viewModel.initialValue,
                                  format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("goal.target.value")
                        
                        Spacer()
                        
                        TextField("",
                                  value: $viewModel.targetValue,
                                  format: .number)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    NavigationLink {
                        UnitPickerView(unit: $viewModel.unitType)
                    } label: {
                        HStack {
                            Text("goal.unit")
                            
                            Spacer()
                            
                            Text(viewModel.unitType.name)
                        }
                    }
                }
                
                Section("goal.colors.section.title") {
                    ColorPicker("goal.progress.color",
                                selection: $viewModel.progressColor,
                                supportsOpacity: false)
                    ColorPicker("goal.background.color",
                                selection: $viewModel.backgroundColor,
                                supportsOpacity: false)
                    ColorPicker("goal.text.color",
                                selection: $viewModel.textColor,
                                supportsOpacity: false)
                }
                
                Section("goal.preview.section.title") {
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
