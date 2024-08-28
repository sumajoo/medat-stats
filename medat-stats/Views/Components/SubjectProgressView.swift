//
//  SubjectProgressView.swift
//  medat-stats
//

import SwiftUI
import SwiftData

struct SubjectProgressView: View {
    
    let subject: String
    let score: Int
    let progress: Double
    
    var body: some View {
            
        VStack(alignment: .leading, spacing: 10) {
            Text("\(Int(score))")
                .font(.title)
                .fontWeight(.bold)
            
            Text(subject)
                .font(.title2)
            
            ProgressView(value: progress)
                .tint(progress < 0.8 ? Color.red : Color.green)
        }
        .padding()
//        .background(.background, in: .rect(cornerRadius: 18))
        .frame(height: 115)
        .background(Color("CardBackground"))
        .cornerRadius(20)
//        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}

#Preview {
    HomeView()
}
