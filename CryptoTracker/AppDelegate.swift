//
//  AppDelegate.swift
//  CryptoTracker
//
//  Created by Fabian Zanotelli Oviedo on 03/04/22.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.button?.image = NSImage(named: NSImage.Name("icons8-bitcoin-26"))
        statusItem.button?.action = #selector(createPopover)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    @objc func createPopover(){
        let mainStoryboard: NSStoryboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        
        guard let vc = mainStoryboard.instantiateController(withIdentifier: "ViewController") as?
                ViewController else {
                fatalError("Unable to find ViewController in StoryBoard")
        }
        guard let button = statusItem.button else {
            fatalError("Unable to fin the StatusButton")
        }
        let popoverView = NSPopover()
        popoverView.contentViewController = vc
        popoverView.behavior = .transient
        popoverView.show(relativeTo: button.bounds, of: button, preferredEdge: .maxX)
    }
}

