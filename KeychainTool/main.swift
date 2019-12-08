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
import CommandLineKit
import KeychainKit
import AuthenticationKit
import CodeSignKit

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
    exit(0)
}

Logger.logMode = .commandLine
Logger.logLevel = verboseOption.value ? .debug : .info

do {
    try CodeSign.signMainExecutableOnceAndRun()
    
    let authenticator = DeviceOwnerAuthenticator()
    try authenticator.grant()
    
    let keychainItems = try Keychain.system.loadItems(
        label: labelOption.value,
        accessGroup: accessGroupOption.value,
        service: serviceOption.value,
        synchronizable: syncOption.value ? true : nil,
        tokenID: tokenOption.value)
    
    Logger.log(important: "Keychain Items Matched: \(keychainItems.count)")
    
    for keychainItem in keychainItems {
        keychainItem.printDetails()
    }
}
catch {
    Logger.log(fatalError: error)
}
