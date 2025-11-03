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
    @State private var selectedGoal: GoalModel? = nil
    
    var totalGoals: Int {
        goals.count
    }
    
    var activeGoals: Int {
        goals.filter(\.isActive).count
    }
    
    var averageProgress: Int {
        Int(goals.reduce(0) { $0 + $1.getProgress() } * 100 / Double(goals.count))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack {
                        HStack {
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
                        
                        HStack {
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
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text(selectedGoal?.getProgress() ?? 0, format: .percent.rounded(increment: 0.01))
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundStyle(.textBlue)
                                
                                Text("stats.progress.title")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(.textSecondary)
                            }
                            
                            Spacer()
                            
                            Picker(selection: $selectedGoal) {
                                ForEach(goals) { goal in
                                    Text(goal.name)
                                        .foregroundStyle(.textPrimary)
                                        .tag(goal)
                                }
                            } label: {
                                Text(selectedGoal?.name ?? "")
                            }
                            .tint(.black)
                            .padding(2)
                            .background(
                                Capsule()
                                    .fill(.iconBlue.opacity(0.14))
                            )
                        }
                        
                        Chart(selectedGoal?.valuesHistory ?? []) { item in
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
                    .padding(20)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.bgWhite)
                    }
                    .systemShadow()
                }
                .padding(.horizontal, 24)
            }
            .background(Color.bgMain)
            .navigationTitle("stats.title")
            .onAppear {
                selectedGoal = goals.first
            }
        }
    }
}

#Preview {
    StatsView()
}
