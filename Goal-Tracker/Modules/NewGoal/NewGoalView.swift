//
//  NewGoalView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 27/09/2025.
//

import SwiftUI

struct NewGoalView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var viewModel = NewGoalViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("goal.name.placeholder", text: $viewModel.model.name)
                }
                
                Section("goal.data.section.title") {
                    HStack {
                        Text("goal.initial.value")
                        
                        Spacer()
                        
                        TextField("",
                                  value: $viewModel.model.initialValue,
                                  format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("goal.target.value")
                        
                        Spacer()
                        
                        TextField("",
                                  value: $viewModel.model.targetValue,
                                  format: .number)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    NavigationLink {
                        UnitPickerView(unit: $viewModel.model.unitType)
                    } label: {
                        HStack {
                            Text("goal.unit")
                            
                            Spacer()
                            
                            Text(viewModel.model.unitType.name)
                        }
                    }
                }
                
                Section("goal.colors.section.title") {
                    ColorPicker("goal.progress.color",
                                selection: Binding(
                                    get: {
                                        viewModel.model.progressColor.color
                                    },
                                    set: {
                                        viewModel.model.progressColor = .init(color: $0)
                                    }))
                    ColorPicker("goal.background.color",
                                selection: Binding(
                                    get: {
                                        viewModel.model.backgroundColor.color
                                    },
                                    set: {
                                        viewModel.model.backgroundColor = .init(color: $0)
                                    }))
                    ColorPicker("goal.text.color",
                                selection: Binding(
                                    get: {
                                        viewModel.model.textColor.color
                                    },
                                    set: {
                                        viewModel.model.textColor = .init(color: $0)
                                    }))
                }
                
                Section("goal.preview.section.title") {
                    GoalProgressView(model: viewModel.model)
                        .listRowInsets(EdgeInsets())
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .close) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        viewModel.saveModel()
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NewGoalView()
}
