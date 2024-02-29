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
            let thisVersion: String = "1.0"
            print("initialImports()")
            if isCurrentVersion() {
                print("--- Current")
            } else {
                print("--- Needs update")
            }

            if !databaseEntityIsEmpty() {
                parseColorString(initialColorsString)
                defaults.set("1.0", forKey: .lastestAppVersion)
                print("App has been updated to version \(thisVersion)\n")
            } else {
                print("App has alreaedy been updated to version \(thisVersion)\n")
            }
        }
        
        func importUpdate(thisVersion: String, colorString: String) {
            let lastSavedAppVersion: String = defaults.string(forKey: .lastestAppVersion) ?? "0.0"
            let updateNeeded = compareVersions(installedVersion: lastSavedAppVersion, updateVersion: thisVersion)
            
            if !updateNeeded {
                print("Current")
                print("App has alreaedy been updated to version \(thisVersion)\n")
            } else {
                print("Needs update for version \(thisVersion)")
                parseColorString(colorString)
                defaults.set(thisVersion, forKey: .lastestAppVersion)
                print("App has been updated to version \(thisVersion)\n")
            }
        }
        
        initialImport()
        importUpdate(thisVersion: "1.1", colorString: colorstrings_1_1)
        importUpdate(thisVersion: "1.2", colorString: colorstrings_1_2)
        importUpdate(thisVersion: "1.3", colorString: colorstrings_1_3)

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
