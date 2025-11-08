//
//  UnitPickerView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 28/09/2025.
//

import SwiftUI

struct UnitPickerView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var unit: UnitType
    
    var body: some View {
        Form {
            Section {
                Picker("", selection: $unit) {
                    ForEach(OtherUnitType.allCases, id: \.self) {
                        Text($0.name)
                            .tag(UnitType.other($0))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
            .listRowBackground(Color.bgPrimary)
            
            Section("goal.unit.currency.section.title") {
                Picker("", selection: $unit) {
                    ForEach(CurrencyUnitType.allCases, id: \.self) {
                        Text($0.name)
                            .tag(UnitType.currency($0))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
            .listRowBackground(Color.bgPrimary)
            
            Section("goal.unit.weight.section.title") {
                Picker("", selection: $unit) {
                    ForEach(WeightUnitType.allCases, id: \.self) {
                        Text($0.name)
                            .tag(UnitType.weight($0))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
            .listRowBackground(Color.bgPrimary)
            
            Section("goal.unit.distance.section.title") {
                Picker("", selection: $unit) {
                    ForEach(DistanceUnitType.allCases, id: \.self) {
                        Text($0.name)
                            .tag(UnitType.distance($0))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
            .listRowBackground(Color.bgPrimary)
        }
        .scrollContentBackground(.hidden)
        .background(.bgMain)
        .onChange(of: unit) { _, _ in
            dismiss()
        }
    }
}

#Preview {
    UnitPickerView(unit: .constant(.other(.none)))
}
