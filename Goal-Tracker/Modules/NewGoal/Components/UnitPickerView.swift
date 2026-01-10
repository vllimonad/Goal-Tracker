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
    
    @State private var selectedSystemUnit: SystemUnitType?
    @State private var selectedCustomUnit: CustomUnitType?
    
    var body: some View {
        Form {
            createOtherUnitsSection()
            
            createCustomUnitsSection()

            createCurrencyUnitsSection()
            
            createWeightUnitsSection()
            
            createDistanceUnitsSection()
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("goal.unit.title")
        .background(.bgModalPage)
        .systemShadow()
        .onChange(of: selectedCustomUnit) { _, _ in
            didSelectCustomUnit()
        }
        .onChange(of: selectedSystemUnit) { _, _ in
            didSelectSystemUnit()
        }
        .onAppear {
            selectedSystemUnit = unit.systemType
            selectedCustomUnit = unit.customType
        }
    }
    
    private func createOtherUnitsSection() -> some View {
        Section {
            Picker("", selection: $selectedSystemUnit) {
                ForEach(OtherUnitType.allCases, id: \.self) {
                    Text($0.name)
                        .tag(SystemUnitType.other($0))
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
        }
        .listRowBackground(Color.bgModalPrimary)
    }
        
    private func createCustomUnitsSection() -> some View {
        Section {
            Picker("", selection: $selectedCustomUnit) {
                ForEach(customUnits) {
                    Text($0.name)
                        .tag($0)
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
        } header: {
            HStack {
                Text("goal.unit.custom.section.title")
                
                Spacer()
                
                NavigationLink {
                    NewUnitTypeView()
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color.iconPrimary)
                }

            }
        }
        .listRowBackground(Color.bgModalPrimary)
    }
    
    private func createCurrencyUnitsSection() -> some View {
        Section("goal.unit.currency.section.title") {
            Picker("", selection: $selectedSystemUnit) {
                ForEach(CurrencyUnitType.allCases, id: \.self) {
                    Text($0.name)
                        .tag(SystemUnitType.currency($0))
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
        }
        .listRowBackground(Color.bgModalPrimary)
    }
    
    private func createWeightUnitsSection() -> some View {
        Section("goal.unit.weight.section.title") {
            Picker("", selection: $selectedSystemUnit) {
                ForEach(WeightUnitType.allCases, id: \.self) {
                    Text($0.name)
                        .tag(SystemUnitType.weight($0))
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
        }
        .listRowBackground(Color.bgModalPrimary)
    }
    
    private func createDistanceUnitsSection() -> some View {
        Section("goal.unit.distance.section.title") {
            Picker("", selection: $selectedSystemUnit) {
                ForEach(DistanceUnitType.allCases, id: \.self) {
                    Text($0.name)
                        .tag(SystemUnitType.distance($0))
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
        }
        .listRowBackground(Color.bgModalPrimary)
    }
    
    private func didSelectCustomUnit() {
        guard
            let selectedUnit = selectedCustomUnit,
            selectedUnit != unit.customType
        else { return }
        
        unit = UnitModel(customType: selectedUnit)
        dismiss()
    }
    
    private func didSelectSystemUnit() {
        guard
            let selectedUnit = selectedSystemUnit,
            selectedUnit != unit.systemType
        else { return }
        
        unit = UnitModel(systemType: selectedUnit)
        dismiss()
    }
}

#Preview {
    UnitPickerView(unit: .constant(UnitModel(systemType: .currency(.eur))))
}
