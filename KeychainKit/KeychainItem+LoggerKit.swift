//
//  KeychainItem+LoggerKit.swift
//  KeychainKit
//
//  Created by Pedro José Pereira Vieito on 26/12/17.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import LoggerKit
import FoundationKit

extension Keychain.Item {
    public func printDetails() {
        Logger.log(success: self)
        Logger.log(info: "Class: \(self.itemClass)")
        
        if let label = self.label {
            Logger.log(info: "Label: \(label)")
        }
        if let applicationLabel = self.applicationLabel {
            Logger.log(info: "Application Label: \(applicationLabel)")
        }
        if let tokenID = self.tokenID {
            Logger.log(info: "Token ID: \(tokenID)")
        }
        if let creationDate = self.creationDate {
            Logger.log(info: "Creation Date: \(creationDate)")
        }
        if let modificationDate = self.modificationDate {
            Logger.log(verbose: "Modification Date: \(modificationDate)")
        }
        if let type = self.type {
            Logger.log(info: "Type: \(type)")
        }
        if let synchronizable = self.synchronizable {
            Logger.log(info: "Synchronizable: \(synchronizable)")
        }
        if let accessGroup = self.accessGroup {
            Logger.log(info: "Access Group: \(accessGroup)")
        }
        if let service = self.service {
            Logger.log(info: "Service: \(service)")
        }
        if let server = self.server {
            Logger.log(info: "Server: \(server)")
        }
        if let account = self.account {
            Logger.log(info: "Account: \(account)")
        }

        if Logger.logLevel >= .verbose, let keyData = self.data {
            if let keyString = String(data: keyData, encoding: .utf8) {
                Logger.log(verbose: "Key: “\(keyString)”")
            }
            else {
                Logger.log(verbose: "Key: 0x\(keyData.hexString)")
            }
        }
    }
}
