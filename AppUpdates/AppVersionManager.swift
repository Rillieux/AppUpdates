//
//  AppVersionManager.swift
//
//

import Foundation

extension UserDefaults {
  enum Key: String {
    case lastestAppVersion
  }

  func integer(forKey key: Key) -> Int {
    return integer(forKey: key.rawValue)
  }

  func string(forKey key: Key) -> String? {
    return string(forKey: key.rawValue)
  }

  func set(_ integer: Int, forKey key: Key) {
    set(integer, forKey: key.rawValue)
  }

  func set(_ object: Any?, forKey key: Key) {
    set(object, forKey: key.rawValue)
  }
}

public func isCurrentVersion() -> Bool {
    printVersions()
    var isCurrent: Bool
    
    let currentAppVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "0"
    
    let defaults = UserDefaults.standard
    let lastSavedAppVersion: String = defaults.string(forKey: .lastestAppVersion) ?? "0"
    
    if lastSavedAppVersion != currentAppVersion as! String {
        print("The previous version is out of date")
        isCurrent = false
    } else {
        print("The previous version is up to date")
        isCurrent = true
    }

    return isCurrent

}

public func compareVersions(installedVersion: String, updateVersion: String) -> Bool {
    let installedVersionsSplit = installedVersion.components(separatedBy: ".")
    let installedMajor = installedVersionsSplit[0]
    let installedMinor = installedVersionsSplit[1]
    
    let updateVersionSplit = updateVersion.components(separatedBy: ".")
    let updateMajor = updateVersionSplit[0]
    let updateMinor = updateVersionSplit[1]

    var updateNeeded: Bool = false
    
    print("Installed Major: \(installedMajor), Minor: \(installedMinor)")
    print("Update Major: \(updateMajor), Minor: \(updateMinor)")
    
    let installedMajorInt = Int(installedMajor) ?? nil
    let installedMinorInt = Int(installedMinor) ?? nil

    let updateMajorInt = Int(updateMajor) ?? nil
    let updateMinorInt = Int(updateMinor) ?? nil
    
    if installedMajor < updateMajor {
        print("Installed Major < Update Major ")
    } else if installedMajor == updateMajor {
        print("Installed Major = Update Major ")
    } else {
        print("Installed Major > Update Major ")
    }

    if installedMinor < updateMinor {
        print("Installed Minor < Update Minor ")
        updateNeeded = true
    } else if installedMinor == updateMinor {
        updateNeeded = false
        print("Installed Minor = Update Minor ")
    } else {
        updateNeeded = false
        print("Installed Minor > Update Minor ")
    }
    
    return updateNeeded
}


public func printVersions() {
    
    let currentAppVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "0"
    
    let defaults = UserDefaults.standard
    let lastSavedAppVersion: String = defaults.string(forKey: .lastestAppVersion) ?? "0"
    
    print("NEW VERSION = \(String(describing: currentAppVersion))")
    print("SAVED VERSION = \(String(describing: lastSavedAppVersion))")
}
