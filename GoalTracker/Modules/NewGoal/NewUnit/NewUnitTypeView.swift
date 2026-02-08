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
                value: $name,
                error: $nameError
            )
            .systemShadow()
            
            CustomTextField(
                title: "new.unit.type.abbreviation.field.title",
                value: $abbreviation,
                error: $abbreviationError
            )
            .systemShadow()
            
            createButton()
            
            Spacer()
        }
        .padding(.top, 40)
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
                .font(.headline)
        })
        .foregroundStyle(Color.textPrimary)
        .padding(.vertical)
        .padding(.horizontal, 80)
        .background()
        .clipShape(.capsule)
        .glassEffect()
        .padding(.top, 20)
    }
    
    private func createUnitType() {
        if name.isEmpty {
            nameError = String(localized: "new.unit.type.name.error")
        } else if abbreviation.isEmpty {
            abbreviationError = String(localized: "new.unit.type.abbreviation.error")
        } else {
            let customUnit = CustomUnitType(name: name, abbreviation: abbreviation)
            modelContext.insert(customUnit)
            dismiss()
        }
    }
}

#Preview {
    NewUnitTypeView()
}
