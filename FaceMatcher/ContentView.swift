//
//  ContentView.swift
//  FaceMatcher
//
//  Created by Erik Partridge on 8/12/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \SavedGame.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<SavedGame>
    
    @State private var showingNameSheet: Bool = false
    @State private var newName: String = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink (destination: SaveView(savedGame: item),  label: {
                        Text(item.name!)
                    })
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showingNameSheet.toggle()
                    }, label: {
                        Label("Add Item", systemImage: "plus")
                    }).sheet(isPresented: $showingNameSheet, onDismiss: addItem) {
                        TextField("Save Name", text: $newName)
                    }
                }
            }
            Text("Select a save")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = SavedGame(context: viewContext)
            newItem.timestamp = Date()
            newItem.name = newName

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
