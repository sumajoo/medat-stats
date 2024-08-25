//
//  Item.swift
//  medat-stats
//
//  Created by Jonas Becker on 13.08.24.
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
