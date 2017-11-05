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
        
        private let Class = String(kSecClass)
        
        private let ValueData = String(kSecValueData)
        private let ValueRef = String(kSecValueRef)
        private let ValuePersistentRef = String(kSecValuePersistentRef)
        
        private let AttributeAccessible = String(kSecAttrAccessible)
        private let AttributeAccessGroup = String(kSecAttrAccessGroup)
        private let AttributeSynchronizable = String(kSecAttrSynchronizable)
        private let AttributeCreationDate = String(kSecAttrCreationDate)
        private let AttributeModificationDate = String(kSecAttrModificationDate)
        private let AttributeDescription = String(kSecAttrDescription)
        private let AttributeComment = String(kSecAttrComment)
        private let AttributeCreator = String(kSecAttrCreator)
        private let AttributeType = String(kSecAttrType)
        private let AttributeLabel = String(kSecAttrLabel)
        private let AttributeIsInvisible = String(kSecAttrIsInvisible)
        private let AttributeIsNegative = String(kSecAttrIsNegative)
        private let AttributeAccount = String(kSecAttrAccount)
        private let AttributeService = String(kSecAttrService)
        private let AttributeGeneric = String(kSecAttrGeneric)
        private let AttributeSecurityDomain = String(kSecAttrSecurityDomain)
        private let AttributeServer = String(kSecAttrServer)
        private let AttributeProtocol = String(kSecAttrProtocol)
        private let AttributeAuthenticationType = String(kSecAttrAuthenticationType)
        private let AttributePort = String(kSecAttrPort)
        private let AttributePath = String(kSecAttrPath)
        
        public var itemClass: ItemClass {
            guard let classString = attributes[Class] as? String else {
                return .genericPassword
            }
            
            guard let itemClass = ItemClass(rawValue: classString as CFString) else {
                return .genericPassword
            }
            
            return itemClass
        }
        public var data: Data? {
            return attributes[ValueData] as? Data
        }
        public var ref: Data? {
            return attributes[ValueRef] as? Data
        }
        public var persistentRef: Data? {
            return attributes[ValuePersistentRef] as? Data
        }
        public var accessible: String? {
            return attributes[AttributeAccessible] as? String
        }
        public var accessGroup: String? {
            return attributes[AttributeAccessGroup] as? String
        }
        public var synchronizable: Bool? {
            return attributes[AttributeSynchronizable] as? Bool
        }
        public var creationDate: Date? {
            return attributes[AttributeCreationDate] as? Date
        }
        public var modificationDate: Date? {
            return attributes[AttributeModificationDate] as? Date
        }
        public var attributeDescription: String? {
            return attributes[AttributeDescription] as? String
        }
        public var comment: String? {
            return attributes[AttributeComment] as? String
        }
        public var creator: String? {
            return attributes[AttributeCreator] as? String
        }
        public var type: String? {
            return attributes[AttributeType] as? String
        }
        public var label: String? {
            return attributes[AttributeLabel] as? String
        }
        public var isInvisible: Bool? {
            return attributes[AttributeIsInvisible] as? Bool
        }
        public var isNegative: Bool? {
            return attributes[AttributeIsNegative] as? Bool
        }
        public var account: String? {
            return attributes[AttributeAccount] as? String
        }
        public var service: String? {
            return attributes[AttributeService] as? String
        }
        public var generic: Data? {
            return attributes[AttributeGeneric] as? Data
        }
        public var securityDomain: String? {
            return attributes[AttributeSecurityDomain] as? String
        }
        public var server: String? {
            return attributes[AttributeServer] as? String
        }
        public var `protocol`: String? {
            return attributes[AttributeProtocol] as? String
        }
        public var authenticationType: String? {
            return attributes[AttributeAuthenticationType] as? String
        }
        public var port: Int? {
            return attributes[AttributePort] as? Int
        }
        public var path: String? {
            return attributes[AttributePath] as? String
        }
        
        private let attributes: [String: Any]
        
        public init(attributes: [String: Any]) {
            self.attributes = attributes
        }
    }
}

