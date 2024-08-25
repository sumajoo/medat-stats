//
//  BlogView.swift
//  medat-stats
//
//  Created by Jonas Becker on 16.08.24.
//

import SwiftUI

struct BlogView: View {
    let entries = [
        ("Wie Du richtig für Zahlenfolgen lernst.", "Heute geht es um Tipps und Tricks zum Meistern der Zahlenfolgen."),
        ("Strategien zur Verbesserung des Gedächtnisses", "Entdecke effektive Techniken, um dein Gedächtnis zu schärfen und Informationen besser zu behalten."),
        ("Erfolgreiches Zeitmanagement für Prüfungen", "Lerne, wie du deine Studienzeit effektiv planst, um stressfrei und gut vorbereitet in die Prüfungen zu gehen."),
        ("Die Bedeutung von Pausen beim Lernen", "Warum regelmäßige Pausen beim Lernen entscheidend sind und wie sie die Konzentration und den Lernerfolg steigern."),
        ("Gesunde Ernährung für ein besseres Lernen", "Erfahre, wie eine ausgewogene Ernährung dein Gehirn unterstützt und deine Lernfähigkeit verbessert.")
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .center, spacing: 12) {
                    ForEach(entries, id: \.0) { entry in
                        BlogEntry(title: entry.0, description: entry.1)
                            .frame(maxWidth: 370)  // Setze eine maximale Breite für die Karten
                    }
                }
                .padding(.vertical)
            }
            .background(.gray.opacity(0.1))
            .background(.blue.opacity(0.1))

            .navigationTitle("Blog")
        }
    }
}

#Preview {
    BlogView()
}
