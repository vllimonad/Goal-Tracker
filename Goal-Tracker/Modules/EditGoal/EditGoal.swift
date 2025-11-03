//
//  EditGoal.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 03/11/2025.
//

import SwiftUI

struct EditGoal: View {
    
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
                TextField("edit.goal.name.value.placeholder", text: $name)
                    .keyboardType(.default)
                    .focused($focusedTextField, equals: .name)
                    .onTapGesture {
                        focusedTextField = .name
                    }
            }
            
            Section("edit.goal.data.section.title") {
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
            
            Section("edit.goal.colors.section.title") {
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
            
            Section("edit.goal.preview.section.title") {
                GoalProgressView(goal: createPreviewGoal())
                    .listRowInsets(EdgeInsets())
            }
        }
        .scrollContentBackground(.hidden)
        .background(.bgMain)
        .navigationTitle("edit.goal.title")
        .navigationBarTitleDisplayMode(.inline)
        .systemShadow()
        .toolbarVisibility(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("edit.goal.save.action.title") {
                    saveChanges()
                    dismiss()
                }
                .foregroundStyle(Color.black)
            }
        }
        .onScrollPhaseChange { _, _ in
            focusedTextField = nil
        }
        .onAppear {
            configureInitialValues()
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
            unitType: goal.unitType,
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
    EditGoal(goal: GoalModel(
        name: "A",
        initialValue: 0,
        targetValue: 1,
        unitType: .currency(.eur),
        colors: ColorsModel()
    ))
}
