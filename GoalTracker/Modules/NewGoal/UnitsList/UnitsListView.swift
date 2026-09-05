//
//  UnitPickerView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 28/09/2025.
//

import SwiftUI
import SwiftData
import WidgetKit

struct UnitsListView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query(sort: [
        SortDescriptor(\CustomUnitType.sortIndex),
        SortDescriptor(\CustomUnitType.creationDate, order: .reverse)
    ])
    private var customUnits: [CustomUnitType]
    
    @Binding var unit: UnitModel
    
    @State private var selectedSystemUnit: SystemUnitType?
    @State private var selectedCustomUnit: CustomUnitType?
    @State private var editMode: EditMode = .inactive
    @State private var isNewUnitTypeViewPresent: Bool = false
    
    var body: some View {
        Form {
            createOtherUnitsSection()
            
            if editMode.isEditing {
                editableCustomUnitsSection()
            } else {
                createCustomUnitsSection()
            }
            
            createCurrencyUnitsSection()
            createWeightUnitsSection()
            createDistanceUnitsSection()
        }
        .environment(\.editMode, $editMode)
        .scrollContentBackground(.hidden)
        .navigationTitle("goal.unit.title")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(editMode.isEditing ? "Done" : "Edit") {
                    withAnimation {
                        editMode = editMode.isEditing ? .inactive : .active
                    }
                }
                .tint(.iconPrimary)
            }
        }
        .background(.bgModalPage)
        .tint(.iconBlue)
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
        .navigationDestination(isPresented: $isNewUnitTypeViewPresent) {
            NewUnitTypeView()
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
        .disabled(editMode.isEditing)
    }
        
    private func createCustomUnitsSection() -> some View {
        Section("goal.unit.custom.section.title") {
            Picker("", selection: $selectedCustomUnit) {
                ForEach(customUnits) { type in
                    Text("\(type.name), \(type.abbreviation)")
                        .tag(type)
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
            
            Button {
                isNewUnitTypeViewPresent = true
            } label: {
                Text("Add")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(.white)
            }
            .listRowBackground(Color.bgBlue)
        }
        .listRowBackground(Color.bgModalPrimary)
    }
    
    private func editableCustomUnitsSection() -> some View {
        Section {
            List {
                ForEach(customUnits) { type in
                    Text("\(type.name), \(type.abbreviation)")
                }
                .onDelete(perform: deleteUnit)
                .onMove(perform: moveUnit)
            }
        } header: {
            HStack {
                Text("goal.unit.custom.section.title")
                
                Spacer()
            }
        }
        .listRowBackground(Color.bgModalPrimary)
        .disabled(editMode.isEditing)
    }
    
    private func createCurrencyUnitsSection() -> some View {
        Section("goal.unit.currency.section.title") {
            Picker("", selection: $selectedSystemUnit) {
                ForEach(CurrencyUnitType.allCases, id: \.self) { type in
                    Text("\(type.name), \(type.abbreviation)")
                        .tag(SystemUnitType.currency(type))
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
        }
        .listRowBackground(Color.bgModalPrimary)
        .disabled(editMode.isEditing)
    }
    
    private func createWeightUnitsSection() -> some View {
        Section("goal.unit.weight.section.title") {
            Picker("", selection: $selectedSystemUnit) {
                ForEach(WeightUnitType.allCases, id: \.self) { type in
                    Text("\(type.name), \(type.abbreviation)")
                        .tag(SystemUnitType.weight(type))
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
        }
        .listRowBackground(Color.bgModalPrimary)
        .disabled(editMode.isEditing)
    }
    
    private func createDistanceUnitsSection() -> some View {
        Section("goal.unit.distance.section.title") {
            Picker("", selection: $selectedSystemUnit) {
                ForEach(DistanceUnitType.allCases, id: \.self) { type in
                    Text("\(type.name), \(type.abbreviation)")
                        .tag(SystemUnitType.distance(type))
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
        }
        .listRowBackground(Color.bgModalPrimary)
        .disabled(editMode.isEditing)
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
    
    private func deleteUnit(_ indexSet: IndexSet) {
        let goals = (try? modelContext.fetch(FetchDescriptor<GoalModel>())) ?? []

        for index in indexSet {
            let unitToDelete = customUnits[index]

            if unitToDelete === selectedCustomUnit {
                selectedCustomUnit = nil
                selectedSystemUnit = .other(.none)
                self.unit = UnitModel(systemType: .other(.none))
            }

            for goal in goals where goal.unit.customType === unitToDelete {
                goal.unit = UnitModel(systemType: .other(.none))
            }

            modelContext.delete(unitToDelete)
        }

        try? modelContext.save()
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    private func moveUnit(from source: IndexSet, to destination: Int) {
        var reorderedUnits = customUnits
        reorderedUnits.move(fromOffsets: source, toOffset: destination)
        for (index, unit) in reorderedUnits.enumerated() {
            unit.sortIndex = index
        }
    }
}

#Preview {
    UnitsListView(unit: .constant(UnitModel(systemType: .currency(.eur))))
}
