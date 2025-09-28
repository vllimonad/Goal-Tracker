//
//  UnitPickerView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 28/09/2025.
//

import SwiftUI

struct UnitPickerView: View {
    
    @State private var unit: UnitType = .none
    
    var body: some View {
        Form {
            Section {
                Picker("", selection: $unit) {
                    Text("None")
                        .tag(UnitType.none)
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
            
            Section("Currency") {
                Picker("", selection: $unit) {
                    ForEach(CurrencyUnitType.allCases, id: \.self) {
                        Text($0.name)
                            .tag(UnitType.currency($0))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
            
            Section("Weight") {
                Picker("", selection: $unit) {
                    ForEach(WeightUnitType.allCases, id: \.self) {
                        Text($0.name)
                            .tag(UnitType.weight($0))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
            
            Section("Distance") {
                Picker("", selection: $unit) {
                    ForEach(DistanceUnitType.allCases, id: \.self) {
                        Text($0.name)
                            .tag(UnitType.distance($0))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
        }
    }
}

#Preview {
    UnitPickerView()
}
