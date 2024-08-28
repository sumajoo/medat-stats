//
//  TestType.swift
//  medat-stats
//

import Foundation
import SwiftData

enum TestType: String, Codable, CaseIterable, Identifiable {
    case biologie = "Biologie"
    case chemie = "Chemie"
    case physik = "Physik"
    case mathematik = "Mathematik"
    case textverständnis = "Textverständnis"
    case figurenmerken = "Figuren zusammensetzen"
    case merkfähigkeit = "Merkfähigkeit"
    case zahlenfolgen = "Zahlenfolgen"
    case wortflüssigkeit = "Wortflüssigkeit"
    case implikationenErkennen = "Implikationen erkennen"
    case emotionenRegulieren = "Emotionen regulieren"
    case emotionenErkennen = "Emotionen erkennen"
    case sozialesEntscheiden = "Soziales Entscheiden"

    var id: String { self.rawValue }

    var maxScore: Int {
        switch self {
        case .biologie: return 40
        case .chemie: return 24
        case .physik: return 18
        case .mathematik: return 12
        case .textverständnis: return 12
        case .figurenmerken: return 15
        case .merkfähigkeit: return 25
        case .zahlenfolgen: return 10
        case .wortflüssigkeit: return 15
        case .implikationenErkennen: return 10
        case .emotionenRegulieren: return 12
        case .emotionenErkennen: return 14
        case .sozialesEntscheiden: return 14
        }
    }
}
