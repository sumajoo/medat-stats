//
//  Item.swift
//  medat-stats
//

import Foundation
import SwiftData

@Model
final class TestResult {
    var id: UUID
    var timestamp: Date
    var testType: TestType
    var testScore: Int
    
    init(id: UUID = UUID(), timestamp: Date, testType: TestType, testScore: Int) {
        self.id = id
        self.timestamp = timestamp
        self.testType = testType
        self.testScore = testScore
    }
}
