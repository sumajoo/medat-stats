//
//  GraphView.swift
//  medat-stats
//

import SwiftUI
import SwiftData
import Charts

struct GraphView: View {
    @Query(sort: \TestResult.timestamp, order: .reverse) private var testResults: [TestResult]
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = ResultInputViewModel()
    
    init(selectedTestType: TestType) {
        let viewModel = ResultInputViewModel()
        viewModel.selectedTestType = selectedTestType
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Spacer()
                    
                    Picker("Test Type", selection: $viewModel.selectedTestType) {
                        ForEach(TestType.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                        .pickerStyle(.navigationLink)
                        
                    }
                    .padding(5)
                    .padding(.horizontal, 30)
                    .background(Color("CardBackground"))
                    .cornerRadius(20)
//                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                    
                    Chart {
                        ForEach(testResults.filter { $0.testType == viewModel.selectedTestType }) { result in
                            LineMark (x: .value("Date", result.timestamp), y: .value("Score", result.testScore))
                            PointMark(
                                x: .value("Date", result.timestamp),
                                y: .value("Score", result.testScore)
                            )
                            .annotation(position: .top) {
                                Text("\(result.testScore)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .frame(height: 250)
                    .chartYScale(domain: 0...viewModel.maxScore)
                    .chartXAxis {
                        AxisMarks(values: .automatic(desiredCount: 5))
                    }
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(25)
                    .background(.background, in: .rect(cornerRadius: 18))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                    
                    Text("Die maximale Punktzahl für \(viewModel.selectedTestType.rawValue) ist \(viewModel.maxScore). Du solltest mindetstens \(viewModel.maxScore - 3) Punkte erreichen, um in Konkurenz zu den zukünftigen Studenten zu stehen.")
                        .foregroundStyle(.secondary)
                        .padding()
                }
            }
            .navigationTitle("Chart")
            .padding()
            .background(.gray.opacity(0.1))
            .background(.blue.opacity(0.1))
        }
        
    }
}

#Preview {
    GraphView(selectedTestType: .biologie)
        .modelContainer(for: TestResult.self)
}
