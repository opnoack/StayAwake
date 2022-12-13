//
//  AppDelegate.swift
//  StayAwake
//
//  Created by Oliver Philipp Noack on 8/12/2022.
//

import AppKit
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    private var oldStatus = 0

    func shell(_ command: String) -> String {
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", command]
        task.launchPath = "/bin/zsh"
        task.standardInput = nil
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!
        
        return output
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "sun.max", accessibilityDescription: "StayAwake")
        }
        setupMenus(statusText: "Off", toggleText: "On")
    }
    
    func setupMenus(statusText: String, toggleText: String) {
        let menu = NSMenu()
        let currentStatus = NSMenuItem(title: "Status: \(statusText)", action: "", keyEquivalent: "")
        menu.addItem(currentStatus)
        let toggle = NSMenuItem(title: "Turn \(toggleText)", action: #selector(toggleStatus), keyEquivalent: "T")
        menu.addItem(toggle)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "Q"))
        statusItem.menu = menu
    }

    private func changeStatusBarButton(buttonName: String) {
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "\(buttonName)", accessibilityDescription: buttonName.description)
        }
    }

    @objc func toggleStatus() {
        if oldStatus == 0 {
            changeStatusBarButton(buttonName: "sun.max.fill")
            setupMenus(statusText: "On", toggleText: "Off")
            shell("caffeinate -disu &>/dev/null")
            oldStatus = 1
        } else {
            changeStatusBarButton(buttonName: "sun.max")
            setupMenus(statusText: "Off", toggleText: "On")
            shell("killall caffeinate >/dev/null")
            oldStatus = 0
        }
    }
    
    @objc func quitApp() {
        shell("killall caffeinate >/dev/null")
        exit(-1)
    }
}
