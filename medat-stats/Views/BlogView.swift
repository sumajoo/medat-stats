//
//  BlogView.swift
//  medat-stats
//

import SwiftUI

struct BlogView: View {
    @State private var selectedArticle: BlogArticle?
    @State private var isShowingFullArticle = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .center, spacing: 12) {
                    ForEach(BlogArticles.articles) { article in
                        BlogEntry(title: article.title, description: article.description)
                            .frame(maxWidth: 370)
                            .onTapGesture {
                                selectedArticle = article
                                isShowingFullArticle = true
                            }
                    }
                }
                .padding(.vertical)
            }
            .background(Color("AppBackground"))
            .navigationTitle("Blog")
            .overlay(fullArticleOverlay)
        }
    }
    
    @ViewBuilder
        private var fullArticleOverlay: some View {
            ZStack {
                if isShowingFullArticle {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.spring()) {
                                isShowingFullArticle = false
                            }
                        }
                    
                    if let article = selectedArticle {
                        FullArticleView(article: article, isShowing: $isShowingFullArticle)
                            .transition(.move(edge: .bottom))
                    }
                }
            }
            .animation(.spring(), value: isShowingFullArticle)
        }
}

#Preview {
    BlogView()
}
