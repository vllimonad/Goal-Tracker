//
//  NewRecordView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 28/10/2025.
//

import SwiftUI

struct NewRecordView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var selectedOperationType: RecordOperationType = .add
    @State private var inputValue: Double? = nil

    @FocusState private var isInputFocused: Bool
    
    var goal: GoalModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Picker("select.operation", selection: $selectedOperationType) {
                    ForEach(RecordOperationType.allCases, id: \.rawValue) {
                        Text($0.rawValue)
                            .tag($0)
                    }
                }
                .pickerStyle(.segmented)
                
                HStack {
                    TextField("enter.value", value: $inputValue, format: .number)
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                        .focused($isInputFocused)
                        .padding()
                        .background(
                            Capsule()
                                .fill(.bgWhite)
                        )
                        .systemShadow()
                        
                    Text(goal.unitType.abbreviation)
                        .font(.subheadline)
                        .foregroundColor(.textPrimary)
                        .padding()
                        .background(
                            Capsule()
                                .fill(.bgWhite)
                        )
                        .systemShadow()
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .navigationTitle(goal.name)
            .navigationSubtitle("new.record")
            .navigationBarTitleDisplayMode(.inline)
            .background(
                Color.bgMain
                    .ignoresSafeArea()
            )
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .close) {
                        dismiss()
                    }
                    .tint(.textPrimary)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("save") {
                        saveRecord()
                        dismiss()
                    }
                    .tint(.textPrimary)
                }
            }
            .toolbarColorScheme(.light)
            .onAppear {
                configureSegmentedPickerAppearance()
            }
        }
    }
    
    private func configureSegmentedPickerAppearance() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
        ]
        UISegmentedControl.appearance()
            .setTitleTextAttributes(attributes, for: .normal)
        UISegmentedControl.appearance()
            .setTitleTextAttributes(attributes, for: .selected)
    }
    
    private func saveRecord() {
        guard let inputValue, inputValue != 0 else { return }
        
        let multiplier = selectedOperationType == .add ? 1.0 : -1.0
        let value = inputValue * multiplier
        
        let record = RecordModel(value: value)
        goal.records.append(record)
        
        try? modelContext.save()
    }
}

#Preview {
    NewRecordView(goal: GoalModel(
        name: "A",
        initialValue: 0,
        targetValue: 0,
        unitType: .currency(.eur),
        colors: ColorsModel()
    ))
}
