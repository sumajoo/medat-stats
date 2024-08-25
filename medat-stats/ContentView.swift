//
//  ContentView.swift
//  medat-stats
//
//  Created by Jonas Becker on 13.08.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            GraphView()
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
