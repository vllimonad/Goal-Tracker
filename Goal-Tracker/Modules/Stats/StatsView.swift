//
//  StatsView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 29/09/2025.
//

import SwiftUI
import SwiftData
import Charts

struct StatsView: View {
    
    @Query(sort: \GoalModel.creationDate) private var goals: [GoalModel]
    @State private var selectedGoalId: UUID? = nil
    
    private var selectedGoal: GoalModel? {
        goals.first(where: { $0.id == selectedGoalId })
    }
    
    private var totalGoals: Int {
        goals.count
    }
    
    private var activeGoals: Int {
        goals
            .filter { !$0.isCompleted }
            .count
    }
    
    private var completedGoals: Int {
        goals.filter(\.isCompleted).count
    }
    
    private var averageProgress: Int {
        let sum = goals.reduce(0) { $0 + $1.getProgress() }
        let count = Double(goals.count) == 0 ? 1 : Double(goals.count)
        let average = Int(sum * 100 / count)
        return average
    }
    
    private var isChartPresented: Bool {
        selectedGoal?.valuesHistory.count ?? 0 > 1
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    statsGrid()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        if let selectedGoal = selectedGoal {
                            HStack(alignment: .top) {
                                selectedGoalTitle(selected: selectedGoal)
                                
                                goalPicker(selected: selectedGoal)
                            }
                            
                            if isChartPresented {
                                recordsChart(for: selectedGoal)
                                
                                recordsHistoryActionView(for: selectedGoal)
                            } else {
                                 chartContentUnavailableView()
                            }
                        } else {
                            statsContentUnavailableView()
                        }
                    }
                    .padding(20)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.bgPrimary)
                    }
                    .systemShadow()
                }
                .padding(.horizontal, 20)
            }
            .background(.bgPage)
            .navigationTitle("stats.title")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                selectedGoalId = selectedGoalId ?? goals.first?.id
            }
            .onChange(of: goals) { _, newValue in
                selectedGoalId = selectedGoalId ?? newValue.first?.id
            }
        }
    }
    
    private func statsGrid() -> some View {
        Grid {
            GridRow(alignment: .top) {
                SingleValueStatsView(
                    title: "stats.total.goals.title",
                    value: totalGoals.description,
                    iconResource: .statsTotalGoals
                )
                
                SingleValueStatsView(
                    title: "stats.active.goals.title",
                    value: activeGoals.description,
                    iconResource: .statsActiveGoals
                )
            }
            
            GridRow(alignment: .top) {
                SingleValueStatsView(
                    title: "stats.avg.progress.title",
                    value: "\(averageProgress)%",
                    iconResource: .statsAvgProgress
                )
                
                SingleValueStatsView(
                    title: "stats.completed.goals.title",
                    value: completedGoals.description,
                    iconResource: .statsCompletedGoals
                )
            }
        }
    }
    
    private func statsContentUnavailableView() -> some View {
        ContentUnavailableView(
            "stats.empty.title",
            systemImage: "chart.bar.xaxis",
            description: Text("stats.empty.description")
        )
    }
    
    private func selectedGoalTitle(selected goal: GoalModel) -> some View {
        VStack(alignment: .leading) {
            Text(
                goal.getProgress(),
                format: .percent.rounded(increment: 0.01)
            )
            .font(.system(size: 24, weight: .semibold))
            .foregroundStyle(.textBlue)
            .contentTransition(.numericText())
            .animation(.snappy, value: goal.getProgress())
            
            Text("stats.progress.title")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.textSecondary)
        }
    }
    
    private func goalPicker(selected goal: GoalModel) -> some View {
        Picker(selection: $selectedGoalId) {
            ForEach(goals) { goal in
                Text(goal.name)
                    .tag(goal.id)
            }
        } label: {
            Text(goal.name)
                .foregroundStyle(.textPrimary)
                .lineLimit(1)
                .truncationMode(.tail)
        }
        .tint(.textPrimary)
        .padding(4)
        .background(
            Capsule()
                .fill(.bgSecondary)
        )
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    private func recordsChart(for goal: GoalModel) -> some View {
        Chart(goal.valuesHistory) { item in
            LineMark(
                x: .value("date", item.date),
                y: .value("value", item.value)
            )
            .interpolationMethod(.monotone)
            .foregroundStyle(.iconBlue)
            .lineStyle(StrokeStyle(lineWidth: 3))
        }
        .chartXAxis {
            AxisMarks {
                AxisValueLabel()
            }
        }
        .chartYAxis {
            AxisMarks {
                AxisGridLine(
                    centered: true,
                    stroke: StrokeStyle(
                        lineWidth: 1,
                        dash: [7, 7]
                    )
                )
                .foregroundStyle(.secondary.opacity(0.4))
                
                AxisValueLabel()
            }
        }
        .frame(height: 200)
    }
    
    private func recordsHistoryActionView(for goal: GoalModel) -> some View {
        NavigationLink {
            RecordsHistoryView(goal: goal)
        } label: {
            HStack {
                Text("stats.records.history.title")
                    .font(.subheadline)
                    .foregroundStyle(.textPrimary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.textSecondary)
            }
        }
        .padding(16)
        .background(.bgSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.top, 8)
    }
    
    private func chartContentUnavailableView() -> some View {
        ContentUnavailableView(
            "stats.chart.empty.title",
            systemImage: "chart.line.uptrend.xyaxis",
            description: Text("stats.chart.empty.description")
        )
        .frame(height: 200)
    }
}

#Preview {
    StatsView()
}
