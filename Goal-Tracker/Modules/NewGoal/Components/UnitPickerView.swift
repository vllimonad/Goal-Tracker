//
//  UnitPickerView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 28/09/2025.
//

import SwiftUI
import SwiftData

struct UnitPickerView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Query private var customUnits: [CustomUnitType]
    @Binding var unit: UnitModel
    
    private var customUnitModels: [UnitModel] {
        customUnits.map {
            UnitModel(customType: $0)
        }
    }
    
    private var systemCurrencyUnitModels: [UnitModel] {
        CurrencyUnitType.allCases.map {
            UnitModel(systemType: .currency($0))
        }
    }
    
    private var systemWeightUnitModels: [UnitModel] {
        WeightUnitType.allCases.map {
            UnitModel(systemType: .weight($0))
        }
    }
    
    private var systemOtherUnitModels: [UnitModel] {
        OtherUnitType.allCases.map {
            UnitModel(systemType: .other($0))
        }
    }
    
    private var systemDistanceUnitModels: [UnitModel] {
        DistanceUnitType.allCases.map {
            UnitModel(systemType: .distance($0))
        }
    }
    
    var body: some View {
        Form {
            Section {
                Picker("", selection: $unit) {
                    ForEach(systemOtherUnitModels) {
                        Text($0.name)
                            .tag($0.id)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
            .listRowBackground(Color.bgModalPrimary)
            
            Section {
                Picker("", selection: $unit) {
                    ForEach(customUnits) {
                        Text($0.name)
                            .tag($0.id)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                HStack {
                    Text("goal.unit.custom.section.title")
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(Color.iconPrimary)
                    }
                }
            }
            .listRowBackground(Color.bgModalPrimary)

            Section("goal.unit.currency.section.title") {
                Picker("", selection: $unit) {
                    ForEach(systemCurrencyUnitModels) {
                        Text($0.name)
                            .tag($0.id)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
            .listRowBackground(Color.bgModalPrimary)
            
            Section("goal.unit.weight.section.title") {
                Picker("", selection: $unit) {
                    ForEach(systemWeightUnitModels) {
                        Text($0.name)
                            .tag($0.id)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
            .listRowBackground(Color.bgModalPrimary)
            
            Section("goal.unit.distance.section.title") {
                Picker("", selection: $unit) {
                    ForEach(systemDistanceUnitModels) {
                        Text($0.name)
                            .tag($0.id)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
            .listRowBackground(Color.bgModalPrimary)
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("goal.unit.title")
        .background(.bgModalPage)
        .systemShadow()
        .onChange(of: unit) { oldValue, newValue in
            dismiss()
        }
    }
}

#Preview {
    UnitPickerView(unit: .constant(UnitModel(systemType: .currency(.eur))))
}
