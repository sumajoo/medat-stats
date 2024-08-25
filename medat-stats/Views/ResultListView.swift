//
//  TestResultListView.swift
//  medat-stats
//
//  Created by Jonas Becker on 14.08.24.
//

import SwiftUI
import SwiftData
import Charts

struct ResultListView: View {
    @Query(sort: \TestResult.timestamp, order: .reverse) private var testResults: [TestResult]
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = ResultInputViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(testResults.filter { $0.testType == viewModel.selectedTestType }) { result in
                        VStack(alignment: .leading) {
                            Text(result.testType.rawValue)
                                .font(.headline)
                            
                            HStack {
                                Text("Score: \(result.testScore)")
                                
                                Spacer()
                                
                                Text(result.timestamp, style: .date)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .onDelete(perform: { offsets in
                        deleteResults(offsets: offsets, filteredResults: testResults.filter { $0.testType == viewModel.selectedTestType })
                    })
                }
                .navigationTitle("Ergebnisse")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) { // TODO: change Animation
                        Picker("Test Type", selection: $viewModel.selectedTestType) {
                            ForEach(TestType.allCases) { testType in
                                Text(testType.rawValue).tag(testType)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func deleteResults(offsets: IndexSet, filteredResults: [TestResult]) {
        for index in offsets {
            let result = filteredResults[index]
            if let originalIndex = testResults.firstIndex(of: result) {
                modelContext.delete(testResults[originalIndex])
            }
        }
    }
}

#Preview {
    ResultListView()
        .modelContainer(for: TestResult.self)
}
