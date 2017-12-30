//
//  KeychainItem.swift
//  KeychainKit
//
//  Created by Pedro José Pereira Vieito on 15/8/17.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import Security

extension Keychain {
    
    public struct Item {
        
        public var itemClass: ItemClass {
            guard let classString = attributes[kSecClass] as? String else {
                return .genericPassword
            }
            
            guard let itemClass = ItemClass(rawValue: classString as CFString) else {
                return .genericPassword
            }
            
            return itemClass
        }
        public var data: Data? {
            return attributes[kSecValueData] as? Data
        }
        public var ref: CFTypeRef? {
            return attributes[kSecValueRef] as CFTypeRef
        }
        public var persistentRef: Data? {
            return attributes[kSecValuePersistentRef] as? Data
        }
        public var accessible: String? {
            return attributes[kSecAttrAccessible] as? String
        }
        public var accessGroup: String? {
            return attributes[kSecAttrAccessGroup] as? String
        }
        public var synchronizable: Bool? {
            return attributes[kSecAttrSynchronizable] as? Bool
        }
        public var creationDate: Date? {
            return attributes[kSecAttrCreationDate] as? Date
        }
        public var modificationDate: Date? {
            return attributes[kSecAttrModificationDate] as? Date
        }
        public var attributeDescription: String? {
            return attributes[kSecAttrDescription] as? String
        }
        public var comment: String? {
            return attributes[kSecAttrComment] as? String
        }
        public var creator: String? {
            return attributes[kSecAttrCreator] as? String
        }
        public var type: String? {
            return attributes[kSecAttrType] as? String
        }
        public var label: String? {
            return attributes[kSecAttrLabel] as? String
        }
        public var applicationLabel: String? {
            return attributes[kSecAttrApplicationLabel] as? String
        }
        public var applicationTag: Data? {
            return attributes[kSecAttrApplicationTag] as? Data
        }
        public var isInvisible: Bool? {
            return attributes[kSecAttrIsInvisible] as? Bool
        }
        public var isNegative: Bool? {
            return attributes[kSecAttrIsNegative] as? Bool
        }
        public var account: String? {
            return attributes[kSecAttrAccount] as? String
        }
        public var service: String? {
            return attributes[kSecAttrService] as? String
        }
        public var generic: Data? {
            return attributes[kSecAttrGeneric] as? Data
        }
        public var securityDomain: String? {
            return attributes[kSecAttrSecurityDomain] as? String
        }
        public var server: String? {
            return attributes[kSecAttrServer] as? String
        }
        public var `protocol`: String? {
            return attributes[kSecAttrProtocol] as? String
        }
        public var authenticationType: String? {
            return attributes[kSecAttrAuthenticationType] as? String
        }
        public var port: Int? {
            return attributes[kSecAttrPort] as? Int
        }
        public var path: String? {
            return attributes[kSecAttrPath] as? String
        }
        public var tokenID: String? {
            return attributes[kSecAttrTokenID] as? String
        }
        
        internal let attributes: [CFString: Any]
        
        public init(attributes: [CFString: Any]) {
            self.attributes = attributes
        }
    }
}

extension Keychain.Item : CustomStringConvertible {
    
    public var description: String {
        switch self.itemClass {
        case .genericPassword:
            return "\(self.service ?? "--") (\(self.accessGroup ?? "No Access Group"))"
        case .internetPassword:
            return "\(self.server ?? "--") (\(self.account ?? "No Account"))"
        default:
            return "\(self.label ?? "--") (\(self.accessGroup ?? "No Access Group"))"
        }
    }
}

