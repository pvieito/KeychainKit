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
    enum KeychainError: LocalizedError {
        case keychainError(OSStatus)
        case alreadyExistingLabel(String)
        
        var errorDescription: String? {
            switch self {
            case .keychainError(let errorCode):
                return "Keychain error code \(errorCode): \(SecCopyErrorMessageString(errorCode, nil) ?? "Unknown error." as CFString)"
            case .alreadyExistingLabel(let label):
                return "Item with label “\(label)” already exists in the Keychain."
            }
        }
    }
    
    public static var system = Keychain()
    
    internal func checkKeychainResult(code: OSStatus) throws {
        guard code == noErr else {
            throw KeychainError.keychainError(code)
        }
    }
    
    public func removeItem(query: [CFString: Any]) throws {
        let resultCode = SecItemDelete(query as CFDictionary)
        try checkKeychainResult(code: resultCode)
    }
    
    public func loadItems(query: [CFString: Any]) throws -> [Item] {
        var result: AnyObject?
        
        let resultCode = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        try checkKeychainResult(code: resultCode)
        guard let itemsArray = result as? [[String: Any]] else {
            throw KeychainError.keychainError(-55)
        }
        
        return itemsArray.map { Item(attributes: $0 as [CFString: Any]) }
    }
    
    public func loadItems(
        label: String? = nil,
        accessGroup: String? = nil,
        service: String? = nil,
        synchronizable: Bool? = nil,
        tokenID: String? = nil) throws -> [Item] {
        var items: [Item] = try self.queryItems()
        
        if let label = label {
            items = items.filter({ $0.label == label })
        }
        
        if let service = service {
            items = items.filter({ $0.service == service })
        }
        
        if let accessGroup = accessGroup {
            items = items.filter({ $0.accessGroup == accessGroup })
        }
        
        if let synchronizable = synchronizable {
            items = items.filter({ $0.synchronizable == synchronizable })
        }
        
        if let tokenID = tokenID {
            items = items.filter({ $0.tokenID == tokenID })
        }
        
        return items
    }
    
    internal func queryItems(
        label: String? = nil,
        accessGroup: String? = nil,
        service: String? = nil,
        synchronizable: Bool? = nil) throws -> [Item] {
        var query: [CFString: Any] = [
            kSecReturnData: kCFBooleanTrue as Any,
            kSecReturnAttributes: kCFBooleanTrue as Any,
            kSecReturnRef: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitAll
        ]
        
        if let label = label {
            query[kSecAttrLabel] = label
        }
        
        if let service = service {
            query[kSecAttrService] = service
        }
        
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup] = accessGroup
        }
        
        if let synchronizable = synchronizable {
            query[kSecAttrSynchronizable] = synchronizable ? kCFBooleanTrue : kCFBooleanFalse
        }
        else {
            query[kSecAttrSynchronizable] = kSecAttrSynchronizableAny
        }
        
        let avaliableClasses: [Item.ItemClass] = [.genericPassword, .internetPassword, .key]
        var items: [Item] = []
        
        for itemClass in avaliableClasses {
            query[kSecClass] = itemClass.rawValue
            
            if let classItems = try? self.loadItems(query: query) {
                items.append(contentsOf: classItems)
            }
        }
        
        return items
    }
}
