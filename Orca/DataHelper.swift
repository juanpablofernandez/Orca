//
//  dataHelper.swift
//  Orca
//
//  Created by Jay on 3/24/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import Foundation
import KeychainAccess

class DataHelper {
    
    static let keychain = Keychain()
    
    static func saveToKeychain(key: String, data: String) {
        self.keychain[key] = data
    }
    
    static func getFromKeychain(key: String) -> String? {
        let data = self.keychain[key]
        return data
    }
    
    static func isKeyInKeychain(key: String) -> Bool {
        if self.getFromKeychain(key: key) != nil {
            return true
        }
        return false
    }
}
