//
//  BlogEntry.swift
//  medat-stats
//

import SwiftUI

struct BlogEntry: View {
    var title: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(.title3, weight: .semibold))
                .foregroundColor(.primary)
                .padding(.top, 8)
            
            Text(description)
                .font(.system(.body, weight: .regular))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 8)
        }
        .padding()
        .frame(maxWidth: .infinity)  // Die Karte nimmt so viel Platz ein, wie sie kann
        .background(.white)
        .cornerRadius(20)
//        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}

#Preview {
    BlogView()
}
