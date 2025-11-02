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

    private let presets = ColorsPresetsDataSource.getPresets()
    private let presetsColumns = [
        GridItem(.adaptive(minimum: 50)),
    ]
    
    @State private var name: String = ""
    
    @State private var initialValue: Double? = nil
    @State private var targetValue: Double? = nil
    @State private var unitType: UnitType = .other(.none)
    
    @State private var selectedPreset: ColorsModel? = nil
    @State private var progressColor: Color = .white
    @State private var backgroundColor: Color = .white
    @State private var textColor: Color = .white
        
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("goal.name.placeholder", text: $name)
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
                        
                        TextField("Enter",
                                  value: $initialValue,
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
                        
                        TextField("Enter",
                                  value: $targetValue,
                                  format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .focused($focusedTextField, equals: .target)
                    }
                    .onTapGesture {
                        focusedTextField = .target
                    }
                    
                    NavigationLink {
                        UnitPickerView(unit: $unitType)
                    } label: {
                        HStack {
                            Text("goal.unit")
                            
                            Spacer()
                            
                            Text(unitType.name)
                        }
                    }
                }
                
                Section("Presets") {
                    ScrollView {
                        LazyVGrid(columns: presetsColumns) {
                            ForEach(presets, id: \.self) { preset in
                                ColorsPreset(colorsModel: preset)
                                    .onTapGesture {
                                        selectedPreset = preset
                                    }
                            }
                        }
                    }
                }
                
                Section("goal.colors.section.title") {
                    ColorPicker("goal.progress.color", selection: $progressColor)
                    ColorPicker("goal.background.color", selection: $backgroundColor)
                    ColorPicker("goal.text.color", selection: $textColor)
                }
                
                Section("goal.preview.section.title") {
                    GoalProgressView(goal: createGoalModel())
                    .listRowInsets(EdgeInsets())
                }
            }
            .scrollContentBackground(.hidden)
            .background(.bgMain)
            .navigationTitle("new.goal")
            .navigationBarTitleDisplayMode(.inline)
            .systemShadow()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .close) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("save") {
                        saveGoal()
                        dismiss()
                    }
                }
            }
            .onScrollPhaseChange { _, _ in
                focusedTextField = nil
            }
        }
        .onAppear {
            selectedPreset = presets.first
        }
    }
    
    private func createGoalModel() -> GoalModel {
        GoalModel(
            name: name,
            initialValue: initialValue ?? 0,
            targetValue: targetValue ?? 0,
            unitType: unitType,
            colors: ColorsModel(
                progress: ColorModel(color: progressColor),
                background: ColorModel(color: backgroundColor),
                text: ColorModel(color: textColor)
            )
        )
    }
    
    private func saveGoal() {
        let goal = createGoalModel()
        modelContext.insert(goal)
    }
}

#Preview {
    NewGoalView()
}
