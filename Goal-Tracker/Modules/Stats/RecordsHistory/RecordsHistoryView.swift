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
        List(goal.records) { record in
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
                Button("record.delete.action.title") {
                    deleteRecord(record)
                }
                .tint(.red)
            }
            .contextMenu {
                Button(
                    "record.delete.action.title",
                    systemImage: "xmark.bin",
                    role: .destructive
                ) {
                    deleteRecord(record)
                }
                .tint(.red)
            }
        }
        .navigationTitle("'\(goal.name)' records")
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .background(Color.bgMain)
        .toolbarVisibility(.hidden, for: .tabBar)
    }
    
    private func deleteRecord(_ record: RecordModel) {
        guard let index = goal.records.firstIndex(of: record) else { return }
        
        goal.records.remove(at: index)
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
