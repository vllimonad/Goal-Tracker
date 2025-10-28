//
//  NewRecordView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 28/10/2025.
//

import SwiftUI

struct NewRecordView: View {
    
    enum OperationType: String, CaseIterable {
        case add = "+"
        case remove = "-"
    }
    
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedOperationType: OperationType = .add
    @State private var inputValue: Int = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                Picker("select.operation", selection: $selectedOperationType) {
                    ForEach(OperationType.allCases, id: \.rawValue) {
                        Text($0.rawValue)
                            .tag($0)
                    }
                }
                .pickerStyle(.segmented)
                
                TextField("value", value: $inputValue, format: .number)
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
                    
            }
            .padding(.horizontal, 24)
            .background(Color.bgMain)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .close) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("save") {
                        
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NewRecordView()
}
