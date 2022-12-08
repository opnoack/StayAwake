//
//  main.swift
//  StayAwake
//
//  Created by Oliver Philipp Noack on 8/12/2022.
//

import AppKit

// 1
let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

// 2
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
