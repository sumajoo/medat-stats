//
//  FullArticleView.swift
//  medat-stats
//

import SwiftUI

struct FullArticleView: View {
    let article: BlogArticle
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            closeButton
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(article.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(article.content)
                        .font(.body)
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("CardBackground"))
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private var closeButton: some View {
        HStack {
            Spacer()
            Button(action: { isShowing = false }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .font(.system(size: 30))
            }
            .padding()
        }
    }
}

// Helper für abgerundete Ecken
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
