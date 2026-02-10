//
//  NewRecordView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 28/10/2025.
//

import SwiftUI

struct NewUnitTypeView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var name: String = ""
    @State private var nameError: String?
    @State private var abbreviation: String = ""
    @State private var abbreviationError: String?
        
    var body: some View {
        VStack(spacing: 20) {
            CustomTextField(
                title: "new.unit.type.name.field.title",
                maxCharCount: 20,
                value: $name,
                error: $nameError
            )
            .systemShadow()
            
            CustomTextField(
                title: "new.unit.type.abbreviation.field.title",
                maxCharCount: 3,
                value: $abbreviation,
                error: $abbreviationError
            )
            .systemShadow()
            
            Spacer()
            
            createButton()
        }
        .padding(.top, 20)
        .padding(.horizontal)
        .background(.bgModalPage)
        .navigationTitle("new.unit.type.title")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func createButton() -> some View {
        Button(action: {
            createUnitType()
        }, label: {
            Text("new.unit.type.action.title")
                .frame(maxWidth: .infinity)
                .font(.headline)
                .padding(.vertical, 18)
        })
        .foregroundStyle(Color.textPrimary)
        .background(Color.bgBlue)
        .clipShape(.capsule)
        .glassEffect()
        .padding(.bottom, 20)
    }
    
    private func createUnitType() {
        guard validateInput() else { return }
        
        let customUnit = CustomUnitType(name: name, abbreviation: abbreviation)
        
        modelContext.insert(customUnit)
        dismiss()
    }
    
    private func validateInput() -> Bool {
        if name.isEmpty {
            nameError = String(localized: "new.unit.type.name.error")
        }
        
        if abbreviation.isEmpty {
            abbreviationError = String(localized: "new.unit.type.abbreviation.error")
        }
        
        return nameError == nil && abbreviationError == nil
    }
}

#Preview {
    NewUnitTypeView()
}
