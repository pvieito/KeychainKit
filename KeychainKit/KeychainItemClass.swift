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
        case key
        case certificate
        case identity
        
        static let all: [ItemClass] = [.genericPassword,
                                       .internetPassword,
                                       .key,
                                       .certificate,
                                       .identity]
        
        public var rawValue: CFString {
            switch self {
            case .genericPassword:
                return kSecClassGenericPassword
            case .internetPassword:
                return kSecClassInternetPassword
            case .key:
                return kSecClassKey
            case .certificate:
                return kSecClassCertificate
            case .identity:
                return kSecClassIdentity
            }
        }
        
        public init?(rawValue: CFString) {
            switch rawValue {
            case kSecClassGenericPassword:
                self = .genericPassword
            case kSecClassInternetPassword:
                self = .internetPassword
            case kSecClassKey:
                self = .key
            case kSecClassCertificate:
                self = .certificate
            case kSecClassIdentity:
                self = .identity
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
            case .key:
                return "Key"
            case .certificate:
                return "Certificate"
            case .identity:
                return "Identity"
            }
        }
    }
}
