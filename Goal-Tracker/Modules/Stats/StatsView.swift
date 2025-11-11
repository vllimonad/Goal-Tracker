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
        goals.filter(\.isActive).count
    }
    
    private var averageProgress: Int {
        let sum = goals.reduce(0) { $0 + $1.getProgress() }
        let count = Double(goals.count) == 0 ? 1 : Double(goals.count)
        let average = Int(sum * 100 / count)
        return average
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Grid {
                        GridRow {
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
                        
                        GridRow {
                            SingleValueStatsView(
                                title: "stats.avg.progress.title",
                                value: "\(averageProgress)%",
                                iconResource: .statsAvgProgress
                            )
                            
                            SingleValueStatsView(
                                title: "stats.active.goals.title",
                                value: activeGoals.description,
                                iconResource: .statsActiveGoals
                            )
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 18) {
                        if goals.isEmpty {
                            ContentUnavailableView(
                                "stats.empty.title",
                                systemImage: "chart.line.uptrend.xyaxis",
                                description: Text("stats.empty.description")
                            )
                        } else if let selectedGoal = selectedGoal {
                            HStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    Text(
                                        selectedGoal.getProgress(),
                                        format: .percent.rounded(increment: 0.01)
                                    )
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundStyle(.textBlue)
                                    
                                    Text("stats.progress.title")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundStyle(.textSecondary)
                                }
                                
                                Spacer()
                                
                                Picker(selection: $selectedGoalId) {
                                    ForEach(goals) { goal in
                                        Text(goal.name)
                                            .tag(goal.id)
                                    }
                                } label: {
                                    Text(selectedGoal.name)
                                        .foregroundStyle(.textPrimary)
                                }
                                .tint(.textPrimary)
                                .padding(4)
                                .background(
                                    Capsule()
                                        .fill(.bgSecondary)
                                )
                            }
                            
                            Chart(selectedGoal.valuesHistory) { item in
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
                            
                            NavigationLink {
                                RecordsHistoryView(goal: selectedGoal)
                                    .toolbarVisibility(.hidden, for: .tabBar)
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
                            .padding(.vertical, 16)
                            .padding(.horizontal, 12)
                            .background(Color.bgSecondary)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.top, 8)
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
            .background(Color.bgPage)
            .navigationTitle("stats.title")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                selectedGoalId = selectedGoalId ?? goals.first?.id
            }
        }
    }
}

#Preview {
    StatsView()
}
