//
//  ContentView.swift
//  medat-stats
//

import SwiftUI

struct ContentView: View {
    let appearance: UITabBarAppearance = UITabBarAppearance()
    init() {
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            GraphView(selectedTestType: .biologie)
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Chart")
                }
            
            ResultInputView()
                .tabItem {
                    Image(systemName: "plus.app.fill")
                    Text("Add")
                }
            
            ResultListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Ergebnisse")
                }
            
            BlogView()
                .tabItem {
                    Image(systemName: "book.pages")
                    Text("Blog")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: TestResult.self)

}
