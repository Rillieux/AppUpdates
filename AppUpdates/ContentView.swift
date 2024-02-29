//
//  ContentView.swift
//  AppUpdates
//
//  Created by Perrache on 27.02.2024..
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \SavedColor.displayOrder, ascending: true)],
        animation: .default)
    private var items: FetchedResults<SavedColor>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { color in
                    VStack (alignment: .leading, spacing: 2) {
                        Text(color.colorHexString ?? "missing")
                            .font(.headline)
                        Text(color.id?.uuidString ?? "")
                            .font(.caption)
                    }
                    .foregroundStyle(.white)
                    .listRowBackground(color.color)
                }
            }
            .navigationTitle("My Colors")
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
