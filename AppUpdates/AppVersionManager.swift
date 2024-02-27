//
//  AppVersionManager.swift
//
//  Created by Dave Kondris on 02/08/21.
//  Copyright © 2021 Dave Kondris. All rights reserved.
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

func isCurrentVersion() -> Bool {
    printVersions()
    var isCurrent: Bool
    
    let currentAppVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "0"
    
    let defaults = UserDefaults.standard
    let lastSavedAppVersion: String = defaults.string(forKey: .lastestAppVersion) ?? "0"
    
    if lastSavedAppVersion != currentAppVersion as! String {
        print("The previous version is out of date")
        isCurrent = false
//        defaults.set(currentAppVersion, forKey: .lastestAppVersion)
    } else {
        print("The previous version is up to date")
        isCurrent = true
    }

    return isCurrent

}

public func printVersions() {
    
    let currentAppVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "0"
    
    let defaults = UserDefaults.standard
    let lastSavedAppVersion: String = defaults.string(forKey: .lastestAppVersion) ?? "0"
    
    print("NEW VERSION = \(String(describing: currentAppVersion))")
    print("SAVED VERSION = \(String(describing: lastSavedAppVersion))")
}
