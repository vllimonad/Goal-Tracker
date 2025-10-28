//
//  NewGoalView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 27/09/2025.
//

import SwiftUI
import SwiftData

struct NewGoalView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @FocusState private var focusedTextField: NewGoalTextFieldType?

    @State private var newGoal = GoalModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("goal.name.placeholder", text: $newGoal.name)
                        .keyboardType(.default)
                        .focused($focusedTextField, equals: .name)
                        .onTapGesture {
                            focusedTextField = .name
                        }
                }
                
                Section("goal.data.section.title") {
                    HStack {
                        Text("goal.initial.value")
                        
                        Spacer()
                        
                        TextField("",
                                  value: $newGoal.initialValue,
                                  format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .focused($focusedTextField, equals: .initial)
                    }
                    .onTapGesture {
                        focusedTextField = .initial
                    }
                    
                    HStack {
                        Text("goal.target.value")
                        
                        Spacer()
                        
                        TextField("",
                                  value: $newGoal.targetValue,
                                  format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .focused($focusedTextField, equals: .target)
                    }
                    .onTapGesture {
                        focusedTextField = .target
                    }
                    
                    NavigationLink {
                        UnitPickerView(unit: $newGoal.unitType)
                    } label: {
                        HStack {
                            Text("goal.unit")
                            
                            Spacer()
                            
                            Text(newGoal.unitType.name)
                        }
                    }
                }
                
                Section("goal.colors.section.title") {
                    ColorPicker("goal.progress.color",
                                selection: Binding(
                                    get: {
                                        newGoal.progressColor.color
                                    },
                                    set: {
                                        newGoal.progressColor = .init(color: $0)
                                    }))
                    ColorPicker("goal.background.color",
                                selection: Binding(
                                    get: {
                                        newGoal.backgroundColor.color
                                    },
                                    set: {
                                        newGoal.backgroundColor = .init(color: $0)
                                    }))
                    ColorPicker("goal.text.color",
                                selection: Binding(
                                    get: {
                                        newGoal.textColor.color
                                    },
                                    set: {
                                        newGoal.textColor = .init(color: $0)
                                    }))
                }
                
                Section("goal.preview.section.title") {
                    GoalProgressView(model: newGoal)
                        .listRowInsets(EdgeInsets())
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.bgMain)
            .shadow(color: .black.opacity(0.1), radius: 20)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .close) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("save") {
                        modelContext.insert(newGoal)
                        dismiss()
                    }
                }
            }
            .onScrollPhaseChange { _, _ in
                focusedTextField = nil
            }
        }
    }
}

#Preview {
    NewGoalView()
}
