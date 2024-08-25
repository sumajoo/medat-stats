//
//  HomeView.swift
//  medat-stats
//
//  Created by Jonas Becker on 13.08.24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query private var testResults: [TestResult]
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ResultInputViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                Text("Guten Morgen Jonas!")
                    .font(.largeTitle)
                    .padding(.bottom, 10)
                
                HStack {
                    Text("\(String(format: "%.2f", viewModel.getAverageScore(for: testResults)))%")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    if let (symbolName, symbolColor) = viewModel.getSymbolAndColor(for: testResults) {
                    Image(systemName: symbolName)
                        .foregroundColor(symbolColor)
                        .rotationEffect(.degrees(45))
                    }
                }
                Text(viewModel.getAverageScoreDescription())
                    .font(.headline)
                    .foregroundColor(.secondary)

                
                Picker("Zeitraum", selection: $viewModel.selectedTimeFrame) {
                    ForEach(viewModel.timeFrames.indices, id: \.self) { index in
                        Text(viewModel.timeFrames[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical, 5)

                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(TestType.allCases, id: \.self) { testType in
                        SubjectProgressView(
                            subject: testType.rawValue,
                            score: viewModel.getLastTestScore(for: testType, allTestResults: testResults) ?? 0,
                            progress: viewModel.getLastTestRang(for: testType, allTestResults: testResults) ?? 0
                        )
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .background(.gray.opacity(0.1))
        .background(.blue.opacity(0.1))
    }
}

#Preview {
    HomeView()
        .modelContainer(for: TestResult.self)
}
