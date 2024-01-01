//
//  CustomCalcApp.swift
//  CustomCalc
//
//  Created by DekotasDEV on 12.05.23.
//

import SwiftUI
/*
@main
struct CustomCalcApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
*/
@main
struct StatusbarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!
    var popover: NSPopover!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create a status bar item
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        // Set the title of the status bar item button
        if let button = statusBarItem.button {
            button.title = "CustCalc"
        }
        
        // Create a SwiftUI view and wrap it in an NSHostingView
        let contentView = RootView()
        let hostingView = NSHostingView(rootView: contentView)
        
        // Set the hosting view as the content of the status bar item
        
        // Create a popover with the hosting view
        popover = NSPopover()
        popover.contentSize = NSSize(width: 200, height: 850)
        popover.contentViewController = NSViewController()
        popover.contentViewController?.view = hostingView
        
        // Add a click event to the status bar item
        if let button = statusBarItem.button {
            button.target = self
            button.action = #selector(statusBarButtonClicked)
        }
    }
    
    @objc func statusBarButtonClicked(_ sender: NSStatusBarButton) {
        if let popover = self.popover {
            if popover.isShown {
                popover.performClose(sender)
            } else {
                if let button = statusBarItem.button {
                    popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                }
            }
        }
    }
    
    @objc func quitClicked() {
        NSApplication.shared.terminate(self)
    }
}
