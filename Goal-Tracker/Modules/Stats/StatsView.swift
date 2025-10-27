//
//  StatsView.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 29/09/2025.
//

import SwiftUI
import Charts

struct StatsView: View {
    
    @State private var viewModel = StatsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 8) {
                    VStack(spacing: 8) {
                        HStack(spacing: 8) {
                            StatView(name: "Total Goals",
                                     value: viewModel.totalGoals.description,
                                     iconResource: .statsTotalGoals)
                            
                            StatView(name: "Active Goals",
                                     value: viewModel.activeGoals.description,
                                     iconResource: .statsActiveGoals)
                        }
                        
                        HStack(spacing: 8) {
                            StatView(name: "Avg Progress",
                                     value: viewModel.averageProgress.description,
                                     iconResource: .statsAvgProgress)
                            
                            StatView(name: "Active Goals",
                                     value: viewModel.activeGoals.description,
                                     iconResource: .statsActiveGoals)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Picker(selection: $viewModel.selectedGoal) {
                            ForEach(viewModel.goals, id: \.self) { goal in
                                Text(goal.name)
                                    .foregroundStyle(.textPrimary)
                                    .tag(goal)
                            }
                        } label: {
                            Text(viewModel.selectedGoal?.name ?? "")
                                .font(.title3.weight(.medium))
                        }
                        .background(
                            Capsule()
                                .fill(.secondary.opacity(0.12))
                        )
                        
                        Chart(viewModel.selectedGoal?.records ?? []) { item in
                            LineMark(
                                x: .value("Date", item.date),
                                y: .value("Value", item.value)
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
            .onAppear {
                viewModel.fetchModels()
            }
        }
    }
}

#Preview {
    StatsView()
}
