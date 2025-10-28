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
    
    @Query private var goals: [GoalModel]
    @State private var selectedGoal: GoalModel? = nil
    
    var totalGoals: Int { goals.count }
    var activeGoals: Int { goals.filter(\.isActive).count }
    var averageProgress: Double {
        goals.reduce(0) { $0 + $1.getProgress() } / Double(goals.count) * 100
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack {
                        HStack {
                            StatView(name: "total.goals",
                                     value: totalGoals.description,
                                     iconResource: .statsTotalGoals)
                            
                            StatView(name: "active.goals",
                                     value: activeGoals.description,
                                     iconResource: .statsActiveGoals)
                        }
                        
                        HStack(spacing: 8) {
                            StatView(name: "avg.progress",
                                     value: averageProgress.description,
                                     iconResource: .statsAvgProgress)
                            
                            StatView(name: "active.goals",
                                     value: activeGoals.description,
                                     iconResource: .statsActiveGoals)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Picker(selection: $selectedGoal) {
                            ForEach(goals, id: \.self) { goal in
                                Text(goal.name)
                                    .foregroundStyle(.textPrimary)
                                    .tag(goal)
                            }
                        } label: {
                            Text(selectedGoal?.name ?? "")
                                .font(.title3.weight(.medium))
                        }
                        .background(
                            Capsule()
                                .fill(.secondary.opacity(0.12))
                        )
                        
                        Chart(selectedGoal?.records ?? []) { item in
                            LineMark(
                                x: .value("date", item.date),
                                y: .value("value", item.value)
                            )
                            .interpolationMethod(.catmullRom)
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
                                AxisGridLine(centered: true,
                                             stroke: StrokeStyle(lineWidth: 1, dash: [7, 7]))
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
                    .shadow(color: Color.black.opacity(0.06),
                            radius: 10,
                            x: 0,
                            y: 0)
                }
                .padding(.horizontal, 24)
            }
            .background(Color.bgMain)
            .navigationTitle("stats.title")
            .onChange(of: goals) { old, new in
                selectedGoal = new.first
            }
        }
    }
}

#Preview {
    StatsView()
}
