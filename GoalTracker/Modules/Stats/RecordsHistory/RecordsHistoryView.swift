//
//  RecordsHistory.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 10/11/2025.
//

import SwiftUI
import WidgetKit

struct RecordsHistoryView: View {
    
    var goal: GoalModel
    
    private var groupedRecordsByMonth: [(key: Date, value: [RecordModel])] {
        Dictionary(grouping: goal.records) {
            let calendar = Calendar.current
            return calendar.date(from: calendar.dateComponents([.month, .year], from: $0.date))!
        }
        .sorted { $0.key > $1.key }
    }
    
    var body: some View {
        List(groupedRecordsByMonth, id: \.key) { section in
            Section(monthName(for: section.key)) {
                ForEach(section.value) {
                    recordRow(for: $0)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(.bgPage)
        .systemShadow()
        .navigationTitle("\(goal.name) records")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func recordRow(for record: RecordModel) -> some View {
        HStack {
            Text("\(String(format: "%+.2f", record.value)) \(goal.unit.abbreviation)")
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
    
    private func monthName(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
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
        withAnimation {
            goal.records.removeAll { record.id == $0.id }
        }
        
        WidgetCenter.shared.reloadAllTimelines()
    }
}

#Preview {
    RecordsHistoryView(goal: GoalModel(
        name: "A",
        initialValue: 0,
        targetValue: 1,
        unit: UnitModel(systemType: .currency(.eur)),
        colors: ColorsModel()
    ))
}
