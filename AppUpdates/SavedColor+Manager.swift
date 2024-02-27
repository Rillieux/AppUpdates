//
//  SavedColor+Manager.swift
//  AppUpdates
//
//  Created by Perrache on 27.02.2024..
//

import CoreData
import SwiftUI

protocol SavedColorDataServiceProtocol {
    func getColors(_ predicate: NSPredicate?) -> [SavedColor]
    func addColor(id: UUID, color: Color, displayOrder: Int)
    func getColor(by id: UUID, with predicate: NSPredicate) -> SavedColor?
    func updateColor(_ color: SavedColor)
    func deleteColor(_ color: SavedColor)
}

class SavedColorDataService: SavedColorDataServiceProtocol {

    var viewContext: NSManagedObjectContext = PersistenceController.shared.viewContext
    
    func getColors(_ predicate: NSPredicate?) -> [SavedColor] {
        let request: NSFetchRequest<SavedColor> = SavedColor.fetchRequest()
        var sortDescriptors = [NSSortDescriptor]()
        let sortByDisplayOrder: NSSortDescriptor = NSSortDescriptor(keyPath: \SavedColor.displayOrder, ascending: true)
        sortDescriptors = [sortByDisplayOrder]
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func addColor(id: UUID, color: Color, displayOrder: Int) {
        let newColor = SavedColor(context: viewContext)
        newColor.id = UUID()
        newColor.color = color
        newColor.displayOrder = Int16(displayOrder)
        saveContext()
    }
    
    func getColor(by id: UUID, with predicate: NSPredicate) -> SavedColor? {
        let request: NSFetchRequest<SavedColor> = SavedColor.fetchRequest()
        request.predicate = predicate
        do {
            return try viewContext.fetch(request).first
        } catch {
            return nil
        }
    }
    
    func updateColor(_ color: SavedColor) {
        saveContext()
    }
    
    func deleteColor(_ color: SavedColor) {
        viewContext.delete(color)
        saveContext()
    }
    
    func saveContext() {
        PersistenceController.shared.save()
    }
}

extension SavedColor {
    
    var color: Color {
        get {
            return Color(hex: colorHexString ?? "#A2A2A2FF") ?? Color.gray
        }
        set {
            colorHexString = newValue.toHex
        }
    }
}
