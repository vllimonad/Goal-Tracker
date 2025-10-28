//
//  NewRecordView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 28/10/2025.
//

import SwiftUI

struct NewRecordView: View {
    
    enum RecordOperationType: String, CaseIterable {
        case add = "+"
        case remove = "-"
    }
    
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
                
                TextField("enter.value", value: $inputValue, format: .number)
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(
                        Capsule()
                            .fill(.bgWhite)
                    )
                    .shadow(color: Color.black.opacity(0.06),
                            radius: 10,
                            x: 0,
                            y: 0)
                    .focused($isInputFocused)
                    
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .background(Color.bgMain)
            .navigationTitle(goal.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .close) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("save") {
                        saveRecord()
                        dismiss()
                    }
                }
            }
            .onAppear {
                isInputFocused = true
            }
        }
    }
    
    func saveRecord() {
        guard let inputValue, inputValue != 0 else { return }
        
        let record = RecordModel(value: inputValue)
        goal.records.append(record)
        
        try? modelContext.save()
    }
}

#Preview {
    NewRecordView(goal: GoalModel())
}
