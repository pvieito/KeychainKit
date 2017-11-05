//
//  KeychainItemClass.swift
//  KeychainKit
//
//  Created by Pedro José Pereira Vieito on 15/8/17.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation

extension Keychain.Item {
    
    public enum ItemClass: RawRepresentable, CustomStringConvertible {
        case genericPassword
        case internetPassword
        
        public var rawValue: CFString {
            switch self {
            case .genericPassword:
                return kSecClassGenericPassword
            case .internetPassword:
                return kSecClassInternetPassword
            }
        }
        
        public init?(rawValue: CFString) {
            switch rawValue {
            case kSecClassGenericPassword:
                self = .genericPassword
            case kSecClassInternetPassword:
                self = .internetPassword
            default:
                return nil
            }
        }
        
        public var description: String {
            switch self {
            case .genericPassword:
                return "Generic Password"
            case .internetPassword:
                return "Internet Password"
            }
        }
    }
}
