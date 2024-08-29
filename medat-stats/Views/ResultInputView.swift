//
//  ResultInputView.swift
//  medat-stats
//

import SwiftUI
import SwiftData

struct ResultInputView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ResultInputViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                Text("Preview")
                    .padding(.horizontal)
                
                SubjectProgressView(subject: viewModel.selectedTestType.rawValue, score: viewModel.score, progress: Double(viewModel.score) / Double(viewModel.selectedTestType.maxScore))
                .padding(5)
                  
                Text("Test Info")
                    .padding(.horizontal)
                
                VStack {
                    HStack {
                        Picker("Test Type", selection: $viewModel.selectedTestType) {
                            ForEach(TestType.allCases) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .onChange(of: viewModel.selectedTestType) {
                            viewModel.score = min(viewModel.score, viewModel.maxScore)
                        }
                        
                        Spacer()
                        
                        Stepper("Score: \(viewModel.score)", value: $viewModel.score, in: 0...viewModel.maxScore)
                        
                        
                    }
                    .padding()
                    .background(.background, in: .rect(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                    Text("Maximaler Score für \(viewModel.selectedTestType.rawValue): \(viewModel.maxScore)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                DatePicker("Test Datum", selection: $viewModel.date, displayedComponents: .date)
                
                .padding()
                .background(.background, in: .rect(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .padding()
            .navigationTitle("New Test Result")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.saveResult(context: context)
                        dismiss()
                    }
                }
            }
            .background(Color("AppBackground"))

            .alert(isPresented: $viewModel.showingAlert) {
                Alert(
                    title: Text(viewModel.isError ? "Fehler" : "Erfolg"),  // Unterscheidung basierend auf isError
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        
    }
}


#Preview {
    ResultInputView()
        .modelContainer(for: TestResult.self)
}
