//
//  main.swift
//  KeychainTool
//
//  Created by Pedro José Pereira Vieito on 30/6/17.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import FoundationKit
import LoggerKit
import ArgumentParser
import KeychainKit
import CodeSignKit

@main
struct KeychainTool: ParsableCommand {
    static var configuration: CommandConfiguration {
        return CommandConfiguration(commandName: String(describing: Self.self))
    }
    
    @Flag(name: .shortAndLong, help: "Show only synchronizable items.")
    var synchronizable: Bool = false

    @Option(name: .shortAndLong, help: "Label.")
    var label: String?

    @Option(name: [.customShort("g"), .long], help: "Access Group.")
    var accessGroup: String?

    @Option(name: .long, help: "Service.")
    var service: String?

    @Option(name: .shortAndLong, help: "Token identifier.")
    var tokenIdentifier: String?

    @Flag(name: .shortAndLong, help: "Verbose mode.")
    var verbose: Bool = false

    func run() throws {
        do {
            Logger.logMode = .commandLine
            Logger.logLevel = self.verbose ? .debug : .info

            try CodeSign.signMainExecutableOnceAndRun()
            
            let keychainItems = try Keychain.system.getItems(
                label: self.label,
                accessGroup: self.accessGroup,
                service: self.service,
                synchronizable: self.synchronizable ? true : nil,
                tokenID: self.tokenIdentifier)
            
            Logger.log(important: "Keychain Items Matched: \(keychainItems.count)")
            
            for keychainItem in keychainItems {
                keychainItem.printDetails()
            }
        }
        catch {
            Logger.log(fatalError: error)
        }
    }
}
