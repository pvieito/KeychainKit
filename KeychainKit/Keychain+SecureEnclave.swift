//
//  Keychain+SecureEnclave.swift
//  KeychainKit
//
//  Created by Pedro José Pereira Vieito on 26/12/17.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import FoundationKit

@available(macOS 10.12.1, *)
extension Keychain {
    public func createSecureEnclaveKeyPair(label: String, accessGroup: String? = nil) throws -> Item {
        let duplicatedItems = (try? loadSecureEnclaveKeys(label: label)) ?? []
        
        guard duplicatedItems.isEmpty else {
            throw KeychainError.alreadyExistingLabel(label)
        }
        
        let publicAccessControl = SecAccessControlCreateWithFlags(
            kCFAllocatorDefault, kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly, [], nil)!
        let privateAccessControl = SecAccessControlCreateWithFlags(
            kCFAllocatorDefault, kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly, [.userPresence, .privateKeyUsage], nil)!
        
        var keyPairQuery: [CFString: Any] = [
            kSecAttrTokenID: kSecAttrTokenIDSecureEnclave,
            kSecAttrKeyType: kSecAttrKeyTypeECSECPrimeRandom,
            kSecAttrKeySizeInBits: 256,
            kSecPublicKeyAttrs: [
                kSecAttrAccessControl: publicAccessControl,
                kSecAttrLabel: "\(label).PublicKey"
            ],
            kSecPrivateKeyAttrs: [
                kSecAttrAccessControl: privateAccessControl,
                kSecAttrIsPermanent: true,
                kSecAttrLabel: "\(label)",
                kSecUseAuthenticationUI: kSecUseAuthenticationUIAllow
            ]
        ]
        
        if let keyAccessGroup = accessGroup {
            keyPairQuery[kSecAttrAccessGroup] = keyAccessGroup
        }
        
        var publicKey, privateKey: SecKey?
        try SecKeyGeneratePair(keyPairQuery as CFDictionary, &publicKey, &privateKey).enforceOSStatus()
        
        guard let privateSecureEnclaveKey = privateKey else {
            throw KeychainError.keychainError(-451)
        }
        
        guard let privateKeyAtributtes = SecKeyCopyAttributes(privateSecureEnclaveKey) as? [CFString: Any] else {
            throw KeychainError.keychainError(-452)
        }
        
        return Item(attributes: privateKeyAtributtes)
    }
    
    public func removeSecureEnclaveKeys(label: String, accessGroup: String) throws {
        let secureEnclaveQuery: [CFString: Any] = [
            kSecClass: kSecClassKey,
            kSecAttrTokenID: kSecAttrTokenIDSecureEnclave,
            kSecAttrAccessGroup: accessGroup,
            kSecAttrLabel: label]
        
        try removeItems(query: secureEnclaveQuery)
        
    }
    
    public func loadSecureEnclaveKeys(label: String? = nil, accessGroup: String? = nil) throws -> [Item] {
        var secureEnclaveQuery: [CFString: Any] = [
            kSecClass: kSecClassKey,
            kSecReturnRef: kCFBooleanTrue as Any,
            kSecReturnAttributes: kCFBooleanTrue as Any,
            kSecAttrTokenID: kSecAttrTokenIDSecureEnclave,
            kSecMatchLimit: kSecMatchLimitAll
        ]
        
        if let keyLabel = label {
            secureEnclaveQuery[kSecAttrLabel] = keyLabel
        }
        
        if let keyAccessGroup = accessGroup {
            secureEnclaveQuery[kSecAttrAccessGroup] = keyAccessGroup
        }
        
        return try self.loadItems(query: secureEnclaveQuery)
    }
}
