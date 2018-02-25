//
//  main.swift
//  KeychainTool
//
//  Created by Pedro José Pereira Vieito on 30/6/17.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import FoundationKit
import LocalAuthentication
import LoggerKit
import CommandLineKit
import KeychainKit

let syncOption = BoolOption(shortFlag: "s", longFlag: "sync", helpMessage: "Show only synchronizable items.")
let labelOption = StringOption(shortFlag: "l", longFlag: "label", helpMessage: "Label.")
let accessGroupOption = StringOption(shortFlag: "g", longFlag: "accessgroup", helpMessage: "Access Group.")
let serviceOption = StringOption(longFlag: "service", helpMessage: "Service.")
let tokenOption = StringOption(shortFlag: "t", longFlag: "token", helpMessage: "Token ID.")
let verboseOption = BoolOption(shortFlag: "v", longFlag: "verbose", helpMessage: "Verbose mode.")
let helpOption = BoolOption(shortFlag: "h", longFlag: "help", helpMessage: "Prints a help message.")

let cli = CommandLineKit.CommandLine()
cli.addOptions(syncOption, labelOption, accessGroupOption, serviceOption, tokenOption, verboseOption, helpOption)

do {
    try cli.parse(strict: true)
}
catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}

if helpOption.value {
    cli.printUsage()
    exit(-1)
}

Logger.logMode = .commandLine
Logger.logLevel = verboseOption.value ? .debug : .info

let authenticationContext = LAContext()
let authenticationPolicy = LAPolicy.deviceOwnerAuthentication

let semaphore = DispatchSemaphore(value: 0)
authenticationContext.evaluatePolicy(authenticationPolicy, localizedReason: ProcessInfo().processName) { (granted, error) in
    
    if let error = error {
        Logger.log(error: error)
        exit(-1)
    }
    
    if granted {
        do {
            let keychainItems = try Keychain.system.loadItems(label: labelOption.value, accessGroup: accessGroupOption.value, service: serviceOption.value, synchronizable: syncOption.value ? true : nil, tokenID: tokenOption.value)
            
            Logger.log(important: "Keychain Items Matched: \(keychainItems.count)")
            
            for keychainItem in keychainItems {
                keychainItem.printDetails()
            }
        }
        catch {
            Logger.log(error: error)
        }
    }
    semaphore.signal()
    
}
semaphore.wait()
