//
//  Keychain.swift
//  KeychainKit
//
//  Created by Pedro José Pereira Vieito on 15/8/17.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import Security

public class Keychain {
    
    public static var system = Keychain()
    
    public func loadItems(query: [CFString: Any]) throws -> [Item] {
        
        var result: AnyObject?
        
        let lastResultCode = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        guard lastResultCode == noErr else {
            throw NSError(domain: "com.apple.security", code: Int(lastResultCode), userInfo: nil)
        }
        
        guard let itemsArray = result as? [[String: Any]] else {
            throw NSError(domain: "com.apple.security", code: -1, userInfo: nil)
        }
        
        return itemsArray.map { Item(attributes: $0) }
    }
    
    public func loadItems(accessGroup: String, service: String, synchronizable: Bool = true) throws -> [Item] {
        
        let query: [CFString: Any] = [
            kSecClass: Item.ItemClass.genericPassword.rawValue,
            kSecAttrAccessGroup: accessGroup as CFString,
            kSecAttrService: service as CFString,
            kSecAttrSynchronizable: (synchronizable ? kCFBooleanTrue : kCFBooleanFalse) as Any ,
            kSecReturnData: kCFBooleanTrue,
            kSecReturnAttributes: kCFBooleanTrue,
            kSecReturnRef: kCFBooleanTrue,
            kSecMatchLimit: kSecMatchLimitAll
        ]
        
        return try self.loadItems(query: query)
    }
    
    public func loadSynchronizableItems() throws -> [Item] {
        
        let synchronizableQuery: [CFString: Any] = [
            kSecAttrSynchronizable: kCFBooleanTrue,
            kSecReturnData: kCFBooleanTrue,
            kSecReturnAttributes: kCFBooleanTrue,
            kSecReturnRef: kCFBooleanTrue,
            kSecMatchLimit: kSecMatchLimitAll
        ]
        
        let genericItems = try self.loadItems(query:
            synchronizableQuery.merging([kSecClass: Item.ItemClass.genericPassword.rawValue as Any], uniquingKeysWith: { $1 }))
        let internetItems = try self.loadItems(query:
            synchronizableQuery.merging([kSecClass: Item.ItemClass.internetPassword.rawValue as Any], uniquingKeysWith: { $1 }))
        return genericItems + internetItems
    }
}
