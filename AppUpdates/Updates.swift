//
//  Updates.swift
//  AppUpdates
//
//  Created by Perrache on 27.02.2024..
//

import SwiftUI

class Updates {
    
    static func imports() {
        
        let dataService: SavedColorDataServiceProtocol = SavedColorDataService()
        let defaults = UserDefaults.standard
        
        print("static func imports()")
        
        func initialImport() {
            print("initialImports()")
            if isCurrentVersion() {
                print("--- Current")
            } else {
                print("--- Needs update")
            }

            if !databaseEntityIsEmpty() {
                parseColorString(initialColorsString)
                defaults.set("1.0", forKey: .lastestAppVersion)
                print("App has been updated to version 1.0")
            } else {
                print("App has alreaedy been updated to version 1.0")
            }
        }
        
        func import_1_1() {
            if isCurrentVersion() {
                print("Current")
                print("App has alreaedy been updated to version 1.1")
            } else {
                print("Needs update for 1.1")
                parseColorString(colorstrings_1_1)
                defaults.set("1.1", forKey: .lastestAppVersion)
                print("App has been updated to version 1.1")
            }

        }
        

        initialImport()
        import_1_1()
                
        func databaseEntityIsEmpty() -> Bool {
            let colorsInDataBase = dataService.getColors(nil)
            if colorsInDataBase.isEmpty {
                return false
            } else {
                return true
            }
        }

        func parseColorString(_ colors: String) {
            print("parseColorString()")

            let colorsBeingImported = colors.components(separatedBy: "\n")
            for color in colorsBeingImported {
                parseColor(color)
            }
        }
        
        func parseColor(_ color: String) {
            print("parseColor \(color)")
            let parts = color.components(separatedBy: "|")
            dataService.addColor(id: UUID(), color: Color(hex: parts[1]) ?? Color.gray, displayOrder: Int(parts[0]) ?? 0)
        }
        

    }
}
