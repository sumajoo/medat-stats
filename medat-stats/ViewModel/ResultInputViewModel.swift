//
//  ResultInputViewModel.swift
//  medat-stats
//

import SwiftUI
import SwiftData

class ResultInputViewModel: ObservableObject {
    @Published var date: Date = .now
    @Published var score: Int = 0
    @Published var selectedTestType = TestType.biologie
    @Published var showingAlert = false
    @Published var alertMessage = ""
    @Published var isError = false
    @Published var selectedTimeFrame = 0
        
    let timeFrames = ["Heute", "Woche", "Monat"]
        
    var maxScore: Int {
        selectedTestType.maxScore
    }
    
    func saveResult(context: ModelContext) {
        do {
            let result = TestResult(timestamp: date, testType: selectedTestType, testScore: score)
            context.insert(result)
//            try context.save()
            
            // Bei erfolgreichem Speichern
            alertMessage = "Testresultat erfolgreich gespeichert!"
            isError = false  // Erfolgreiche Nachricht, daher kein Fehler
            showingAlert = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.showingAlert = false
                        }
//        } catch {
//            // Bei einem Fehler während des Speichervorgangs
//            alertMessage = "Speichern fehlgeschlagen: \(error.localizedDescription)"
//            isError = true  // Fehlerstatus auf true setzen
//            showingAlert = true
        }
    }
    
    func getLastTestScore(for testType: TestType, allTestResults: [TestResult]) -> Int? {
            return allTestResults
                .filter { $0.testType == testType }
                .sorted(by: { $0.timestamp > $1.timestamp })
                .first?.testScore
        }
    
    func getLastTestRang(for testType: TestType, allTestResults: [TestResult]) -> Double? {
            guard let lastScore = getLastTestScore(for: testType, allTestResults: allTestResults),
                  testType.maxScore > 0 else {
                return nil
            }
            
            return Double(lastScore) / Double(testType.maxScore)
        }

    
    static func getAverageOfLastDay(for allTestResults: [TestResult]) -> Double {
        let latestScores = Dictionary(grouping: allTestResults, by: { $0.testType })
            .mapValues { $0.max(by: { $0.timestamp < $1.timestamp })?.testScore ?? 0 }
        
        let totalScore = latestScores.values.reduce(0, +)
        let maxPossibleScore = TestType.allCases.reduce(0) { $0 + $1.maxScore }
        
        return maxPossibleScore > 0 ? (Double(totalScore) / Double(maxPossibleScore)) * 100 : 0
    }
    
    static func getAverageOfLastWeek(for allTestResults: [TestResult]) -> Double {
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let lastWeekResults = allTestResults.filter { $0.timestamp >= oneWeekAgo }
        
        guard !lastWeekResults.isEmpty else { return 0.0 }
        
        let totalScore = lastWeekResults.reduce(0.0) { $0 + Double($1.testScore) }
        let maxPossibleScore = lastWeekResults.reduce(0) { $0 + $1.testType.maxScore }
        
        return maxPossibleScore > 0 ? (totalScore / Double(maxPossibleScore)) * 100 : 0
    }
        
    static func getAverageOfLastMonth(for allTestResults: [TestResult]) -> Double {
        let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: Date())!
        let lastMonthResults = allTestResults.filter { $0.timestamp >= oneMonthAgo }
        
        guard !lastMonthResults.isEmpty else { return 0.0 }
        
        let totalScore = lastMonthResults.reduce(0.0) { $0 + Double($1.testScore) }
        let maxPossibleScore = lastMonthResults.reduce(0) { $0 + $1.testType.maxScore }
        
        return maxPossibleScore > 0 ? (totalScore / Double(maxPossibleScore)) * 100 : 0
    }
    
    func getAverageScore(for testResults: [TestResult]) -> Double {
        switch selectedTimeFrame {
        case 0:
            return ResultInputViewModel.getAverageOfLastDay(for: testResults)
        case 1:
            return ResultInputViewModel.getAverageOfLastWeek(for: testResults)
        case 2:
            return ResultInputViewModel.getAverageOfLastMonth(for: testResults)
        default:
            return 0.0
        }
    }
    
    func getAverageScoreDescription() -> String {
        switch selectedTimeFrame {
        case 0:
            return "Dein aktueller Prozentrang nach den aktuellsten Ergebnissen."
        case 1:
            return "Dein durchschnittlicher Prozentrang der letzten Woche."
        case 2:
            return "Dein durchschnittlicher Prozentrang des letzten Monats."
        default:
            return ""
        }
    }

    func getSymbolAndColor(for testResults: [TestResult]) -> (String, Color)? {
        guard selectedTimeFrame == 0 else { return nil }  // Nur für "Heute"
        
        let currentScore = ResultInputViewModel.getAverageOfLastDay(for: testResults)
        let lastWeekAverage = ResultInputViewModel.getAverageOfLastWeek(for: testResults)
        
        if currentScore > lastWeekAverage {
            return ("arrowshape.up.fill", .green)
        } else if currentScore < lastWeekAverage {
            return ("arrowshape.down.fill", .red)
        } else {
            return ("arrowshape.right.fill", .yellow)
        }
    }
}
