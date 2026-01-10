//
//  NewRecordView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 28/10/2025.
//

import SwiftUI

struct NewUnitTypeView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @State private var name: String = ""
    @State private var nameError: String?
    @State private var abbreviation: String = ""
    @State private var abbreviationError: String?
        
    var body: some View {
        Form {
            Section("new.unit.type.name.field.title") {
                nameTextField()
            }
            .listRowBackground(Color.bgModalPrimary)
            
            Section("new.unit.type.abbreviation.field.title") {
                abbreviationTextField()
            }
            .listRowBackground(Color.bgModalPrimary)
            
            Section {
                Button(action: {
                    createUnitType()
                }, label: {
                    Text("new.unit.type.action.title")
                        .font(.headline)
                })
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color.textPrimary)
            }
            .listRowBackground(Color.bgBlue)
        }
        .scrollContentBackground(.hidden)
        .background(.bgModalPage)
        .navigationTitle("new.unit.type.title")
        .navigationBarTitleDisplayMode(.inline)
        .systemShadow()
    }
    
    private func nameTextField() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("new.goal.name.field.placeholder", text: $name)
                .keyboardType(.default)
                .onChange(of: name) { oldValue, newValue in
                    nameError = nil
                    
                    if newValue.count > 20 {
                        name = oldValue
                    }
                }
            
            if let error = nameError {
                Text(error)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
        .animation(.easeOut, value: nameError)
    }
    
    private func abbreviationTextField() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("new.goal.abbreviation.field.placeholder", text: $abbreviation)
                .keyboardType(.default)
                .onChange(of: abbreviation) { oldValue, newValue in
                    abbreviationError = nil
                    
                    if newValue.count > 3 {
                        abbreviation = oldValue
                    }
                }
            
            if let error = abbreviationError {
                Text(error)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
        .animation(.easeOut, value: abbreviationError)
    }
    
    private func createUnitType() {
        if name.isEmpty {
            nameError = String(localized: "new.unit.type.name.error")
        } else if abbreviation.isEmpty {
            abbreviationError = String(localized: "new.unit.type.abbreviation.error")
        } else {
            let customUnit = CustomUnitType(name: name, abbreviation: abbreviation)
            context.insert(customUnit)
            dismiss()
        }
    }
}

#Preview {
    NewUnitTypeView()
}
