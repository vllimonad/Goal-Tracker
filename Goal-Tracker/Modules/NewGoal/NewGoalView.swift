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

    private let presets = PresetsDataSource.getAll()
    private let presetsColumns = [
        GridItem(.adaptive(minimum: 54)),
    ]
    
    @State private var name: String = ""
    
    @State private var initialValue: Double? = nil
    @State private var targetValue: Double? = nil
    @State private var unitType: UnitType = .other(.none)
    
    @State private var selectedPresetIndex: Int? = PresetsDataSource.initialIndex
    @State private var progressColor: Color = PresetsDataSource.getInitial().progress.color
    @State private var backgroundColor: Color = PresetsDataSource.getInitial().background.color
    @State private var textColor: Color = PresetsDataSource.getInitial().text.color
        
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("new.goal.name.value.placeholder", text: $name)
                        .keyboardType(.default)
                        .focused($focusedTextField, equals: .name)
                        .onTapGesture {
                            focusedTextField = .name
                        }
                }
                .listRowBackground(Color.bgSecondary)
                
                Section("new.goal.data.section.title") {
                    HStack {
                        Text("new.goal.initial.title")
                        
                        Spacer()
                        
                        TextField(
                            "new.goal.initial.value.placeholder",
                            value: $initialValue,
                            format: .number
                        )
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .focused($focusedTextField, equals: .initial)
                    }
                    .onTapGesture {
                        focusedTextField = .initial
                    }
                    
                    HStack {
                        Text("new.goal.target.title")
                        
                        Spacer()
                        
                        TextField(
                            "new.goal.target.value.placeholder",
                            value: $targetValue,
                            format: .number
                        )
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
                            Text("new.goal.unit.picker.title")
                            
                            Spacer()
                            
                            Text(unitType.name)
                        }
                    }
                }
                .listRowBackground(Color.bgSecondary)
                
                Section("new.goal.presets.section.title") {
                    ScrollView {
                        LazyVGrid(columns: presetsColumns) {
                            ForEach(Array(presets.enumerated()), id: \.offset) { index, preset in
                                ColorsPreset(
                                    colorsModel: preset,
                                    isSelected: index == selectedPresetIndex
                                )
                                .frame(height: 40)
                                .onTapGesture {
                                    selectPreset(index)
                                }
                                .animation(.default, value: selectedPresetIndex)
                            }
                        }
                        .scrollDisabled(true)
                    }
                }
                .listRowBackground(Color.bgSecondary)
                
                Section("new.goal.colors.section.title") {
                    ColorPicker(
                        "new.goal.progress.color.picker.title",
                        selection: $progressColor
                    )
                    .onChange(of: progressColor) { _, _ in
                        validateColorChange()
                    }
                    
                    ColorPicker(
                        "new.goal.background.color.picker.title",
                        selection: $backgroundColor
                    )
                    .onChange(of: backgroundColor) { _, _ in
                        validateColorChange()
                    }
                    
                    ColorPicker(
                        "new.goal.text.color.picker.title",
                        selection: $textColor
                    )
                    .onChange(of: textColor) { _, _ in
                        validateColorChange()
                    }
                }
                .listRowBackground(Color.bgSecondary)
                
                Section("new.goal.preview.section.title") {
                    GoalProgressView(goal: createGoalModel())
                    .listRowInsets(EdgeInsets())
                }
            }
            .scrollContentBackground(.hidden)
            .background(.bgPrimary)
            .navigationTitle("new.goal.title")
            .navigationBarTitleDisplayMode(.inline)
            .systemShadow()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .close) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("new.goal.save.action.title") {
                        saveGoal()
                        dismiss()
                    }
                }
            }
            .onScrollPhaseChange { _, _ in
                focusedTextField = nil
            }
        }
    }
    
    private func selectPreset(_ index: Int) {
        let preset = presets[index]
        
        progressColor = preset.progress.color
        backgroundColor = preset.background.color
        textColor = preset.text.color
        
        selectedPresetIndex = index
    }
    
    private func validateColorChange() {
        guard let selectedPresetIndex = selectedPresetIndex else { return }
        
        let preset = presets[selectedPresetIndex]
        
        guard
            preset.progress.color != progressColor
                || preset.background.color != backgroundColor
                || preset.text.color != textColor
        else {
            return
        }
        
        self.selectedPresetIndex = nil
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
