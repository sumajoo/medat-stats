//
//  BlogArticle.swift
//  medat-stats
//
//  Created by Jonas Becker on 29.08.24.
//

import Foundation

struct BlogArticle: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let content: String
}
