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
    @State private var nameError: String?
    
    @State private var initialValue: Double? = nil
    @State private var targetValue: Double? = nil
    @State private var unit: UnitModel = UnitModel(systemType: .other(.none))
    
    @State private var selectedPresetIndex: Int? = PresetsDataSource.initialIndex
    @State private var progressColor: Color = PresetsDataSource.getInitial().progress.color
    @State private var backgroundColor: Color = PresetsDataSource.getInitial().background.color
    @State private var textColor: Color = PresetsDataSource.getInitial().text.color
        
    var body: some View {
        NavigationView {
            Form {
                Section {
                    nameTextField()
                }
                .listRowBackground(Color.bgModalPrimary)
                
                Section("new.goal.data.section.title") {
                    initialValueTextField()
                    
                    targetValueTextField()
                    
                    unitPickerView()
                }
                .listRowBackground(Color.bgModalPrimary)
                
                Section("new.goal.presets.section.title") {
                    presetsView()
                }
                .listRowBackground(Color.bgModalPrimary)
                
                Section("new.goal.colors.section.title") {
                    colorPickers()
                }
                .listRowBackground(Color.bgModalPrimary)
                
                Section("new.goal.preview.section.title") {
                    goalPreview()
                }
            }
            .scrollContentBackground(.hidden)
            .background(.bgModalPage)
            .navigationTitle("new.goal.title")
            .navigationBarTitleDisplayMode(.inline)
            .systemShadow()
            .toolbar {
                toolbarContent()
            }
            .onScrollPhaseChange { _, _ in
                focusedTextField = nil
            }
        }
    }
    
    private func nameTextField() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("new.goal.name.value.placeholder", text: $name)
                .keyboardType(.default)
                .focused($focusedTextField, equals: .name)
                .onChange(of: name) { oldValue, newValue in
                    nameError = nil
                    
                    if newValue.count > 30 {
                        name = oldValue
                    }
                }
                .onTapGesture {
                    focusedTextField = .name
                }
            
            if let error = nameError {
                Text(error)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
        .animation(.easeOut, value: nameError)
    }
    
    private func initialValueTextField() -> some View {
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
    }
    
    private func targetValueTextField() -> some View {
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
    }
    
    private func unitPickerView() -> some View {
        NavigationLink {
            UnitPickerView(unit: $unit)
        } label: {
            HStack {
                Text("new.goal.unit.picker.title")
                
                Spacer()
                
                Text(unit.name)
            }
        }
    }
    
    private func presetsView() -> some View {
        LazyVGrid(columns: presetsColumns) {
            ForEach(Array(presets.enumerated()), id: \.offset) { index, preset in
                ColorsPresetView(
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
    }
    
    @ViewBuilder
    private func colorPickers() -> some View {
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
    
    private func goalPreview() -> some View {
        GoalProgressView(goal: createGoalModel())
            .listRowInsets(EdgeInsets())
    }
    
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(role: .close) {
                dismiss()
            }
        }
        
        ToolbarItem(placement: .topBarTrailing) {
            Button("new.goal.save.action.title") {
                saveGoal()
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
            unit: unit,
            colors: ColorsModel(
                progress: ColorModel(color: progressColor),
                background: ColorModel(color: backgroundColor),
                text: ColorModel(color: textColor)
            )
        )
    }
    
    private func saveGoal() {
        guard !name.isEmpty else {
            nameError = String(localized: "new.goal.name.value.error")
            return
        }
        
        let goal = createGoalModel()
        modelContext.insert(goal)
        dismiss()
    }
}

#Preview {
    NewGoalView()
}
