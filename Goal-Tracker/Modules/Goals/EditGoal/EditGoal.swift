//
//  EditGoal.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 03/11/2025.
//

import SwiftUI

struct EditGoalView: View {
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedTextField: NewGoalTextFieldType?
    
    var goal: GoalModel
    
    @State private var name: String = ""
    @State private var targetValue: Double = 0
    
    @State private var progressColor: Color = .white
    @State private var backgroundColor: Color = .white
    @State private var textColor: Color = .white
    
    var body: some View {
        Form {
            Section("edit.goal.name.section.title") {
                nameTextField()
            }
            .listRowBackground(Color.bgPrimary)
            
            Section("edit.goal.data.section.title") {
                targetValueRow()
            }
            .listRowBackground(Color.bgPrimary)
            
            Section("edit.goal.colors.section.title") {
                colorPickers()
            }
            .listRowBackground(Color.bgPrimary)
            
            Section("edit.goal.preview.section.title") {
                goalPreview()
            }
        }
        .scrollContentBackground(.hidden)
        .background(.bgPage)
        .navigationTitle("edit.goal.title")
        .navigationBarTitleDisplayMode(.inline)
        .systemShadow()
        .toolbar {
            toolBarContent()
        }
        .onScrollPhaseChange { _, _ in
            focusedTextField = nil
        }
        .onAppear {
            configureInitialValues()
        }
    }
    
    private func nameTextField() -> some View {
        TextField("edit.goal.name.value.placeholder", text: $name)
            .keyboardType(.default)
            .focused($focusedTextField, equals: .name)
            .onTapGesture {
                focusedTextField = .name
            }
    }
    
    private func targetValueRow() -> some View {
        HStack {
            Text("edit.goal.target.title")
            
            Spacer()
            
            TextField(
                "edit.goal.target.value.placeholder",
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
    
    @ViewBuilder
    private func colorPickers() -> some View {
        ColorPicker(
            "edit.goal.progress.color.picker.title",
            selection: $progressColor
        )
        
        ColorPicker(
            "edit.goal.background.color.picker.title",
            selection: $backgroundColor
        )
        
        ColorPicker(
            "edit.goal.text.color.picker.title",
            selection: $textColor
        )
    }
    
    private func goalPreview() -> some View {
        GoalProgressView(goal: createPreviewGoal())
            .listRowInsets(EdgeInsets())
    }
    
    @ToolbarContentBuilder
    private func toolBarContent() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("edit.goal.save.action.title") {
                saveChanges()
                dismiss()
            }
            .foregroundStyle(.textPrimary)
        }
    }
    
    private func configureInitialValues() {
        name = goal.name
        targetValue = goal.targetValue
        progressColor = goal.colors.progress.color
        backgroundColor = goal.colors.background.color
        textColor = goal.colors.text.color
    }
    
    private func createPreviewGoal() -> GoalModel {
        GoalModel(
            name: name,
            initialValue: goal.initialValue,
            targetValue: targetValue,
            unit: goal.unit,
            colors: ColorsModel(
                progress: progressColor,
                background: backgroundColor,
                text: textColor
            )
        )
    }
    
    private func saveChanges() {
        goal.name = name
        goal.targetValue = targetValue
        goal.colors = ColorsModel(
            progress: progressColor,
            background: backgroundColor,
            text: textColor
        )
    }
}

#Preview {
    EditGoalView(goal: GoalModel(
        name: "A",
        initialValue: 0,
        targetValue: 1,
        unit: UnitModel(systemType: .currency(.eur)),
        colors: ColorsModel()
    ))
}
