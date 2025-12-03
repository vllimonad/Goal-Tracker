//
//  RecordsHistory.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 10/11/2025.
//

import SwiftUI

struct RecordsHistoryView: View {
    
    var goal: GoalModel
    
    var body: some View {
        List(goal.records) {
            recordRow(for: $0)
        }
        .scrollContentBackground(.hidden)
        .background(.bgPage)
        .systemShadow()
        .navigationTitle("\(goal.name) records")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarVisibility(.hidden, for: .tabBar)
    }
    
    private func recordRow(for record: RecordModel) -> some View {
        HStack {
            Text("\(String(format: "%+.2f", record.value)) \(goal.unitType.abbreviation)")
                .font(.headline)
                .foregroundStyle(.textPrimary)
            
            Spacer()
            
            Text(record.date, format: .dateTime)
                .font(.subheadline)
                .foregroundStyle(.textSecondary)
        }
        .listRowBackground(Color.bgPrimary)
        .listRowInsets(.vertical, 16)
        .swipeActions {
            swipeActions(for: record)
        }
        .contextMenu {
            contextMenu(for: record)
        }
    }
    
    private func swipeActions(for record: RecordModel) -> some View {
        Button("record.delete.action.title") {
            deleteRecord(record)
        }
        .tint(.red)
    }
    
    private func contextMenu(for record: RecordModel) -> some View {
        Button(
            "record.delete.action.title",
            systemImage: "xmark.bin",
            role: .destructive
        ) {
            deleteRecord(record)
        }
        .tint(.red)
    }
    
    private func deleteRecord(_ record: RecordModel) {        
        goal.records.removeAll { record.id == $0.id }
    }
}

#Preview {
    RecordsHistoryView(goal: GoalModel(
        name: "A",
        initialValue: 0,
        targetValue: 1,
        unitType: .currency(.eur),
        colors: ColorsModel()
    ))
}
