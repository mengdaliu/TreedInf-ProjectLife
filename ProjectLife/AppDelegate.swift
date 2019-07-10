//
//  AppDelegate.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/2.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    

    let userDefaults = UserDefaults.init(suiteName: "Test User")
    var windowController : NSWindowController?
    var window : NSWindow?
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        self.windowController = NSApplication.shared.mainWindow?.windowController
        self.window = self.windowController?.window
        
        let loadedData = UserDefaults.standard.data(forKey: "Theme Color")
        
        if loadedData != nil{
            var loadedColor : NSColor?
            do {
                try loadedColor =  NSKeyedUnarchiver.unarchivedObject(ofClasses : [NSColor.self], from: loadedData!) as? NSColor
                handleChangeMainWindowColor(color: loadedColor!)
            } catch {
                //let color = handleStoreColor(data : [0, 0.07, 0.21, 1])
                //handleChangeMainWindowColor(color : color)
            }
        } else {
            let color = handleStoreColor(data : [0, 0.07, 0.21, 1])
            handleChangeMainWindowColor(color : color)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    // MARK: - Core Data stack
    
    func handleSelect(item : NSMenuItem) {
        let all = item.menu?.items
        for i in all!{
            i.state = .off
        }
        item.state = .on
    }
    
    func handleStoreColor(data : [Double]) -> NSColor {
        let red = data[0]
        let green = data[1]
        let blue = data[2]
        let alpha = data[3]
        let color = NSColor.init(calibratedRed: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
        var data : Data?
        do {
            try data = NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
        } catch {
            return color
        }
        self.userDefaults?.register(defaults: ["Theme Color": data ?? NSColor.init()])
        return color
    }
    
    func handleChangeMainWindowColor(color : NSColor) {
        window?.backgroundColor = color
    }
    
    @IBAction func selectBrown(_ sender: NSMenuItem) {
        handleSelect(item : sender)
        let color = handleStoreColor(data : [0.2775, 0.09, 0.03, 1])
        handleChangeMainWindowColor(color : color)
    }
    
    @IBAction func selectGrey(_ sender: NSMenuItem) {
        handleSelect(item : sender)
        let color = handleStoreColor(data : [0.15, 0.15, 0.15, 1])
        handleChangeMainWindowColor(color : color)
    }
    
    @IBAction func selectRed(_ sender: NSMenuItem) {
        handleSelect(item : sender)
        let color = handleStoreColor(data : [0.3, 0, 0, 1])
        handleChangeMainWindowColor(color : color)
    }
    
    @IBAction func selectBlue(_ sender: NSMenuItem) {
        handleSelect(item : sender)
        let color = handleStoreColor(data : [0, 0.07, 0.21, 1])
        handleChangeMainWindowColor(color : color)
    }
    
    @IBAction func selectGreen(_ sender: NSMenuItem) {
        handleSelect(item : sender)
        let color = handleStoreColor(data : [0.09, 0.15, 0.075, 1])
        handleChangeMainWindowColor(color : color)
    }
    
    @IBAction func selectWhite(_ sender: NSMenuItem) {
        handleSelect(item : sender)
        let color = handleStoreColor(data : [1, 1, 1, 1])
        handleChangeMainWindowColor(color : color)
    }
    @IBAction func selectPeru(_ sender: NSMenuItem) {
        handleSelect(item : sender)
        let color = handleStoreColor(data : [0.21, 0.14, 0.05, 1])
        handleChangeMainWindowColor(color : color)
    }
    @IBAction func selectBlack(_ sender: NSMenuItem) {
        handleSelect(item : sender)
        let color = handleStoreColor(data : [0, 0, 0, 1])
        handleChangeMainWindowColor(color : color)
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows: Bool) -> Bool {
        if hasVisibleWindows {
            self.window?.orderFront(self)
        }
        else {
            self.window?.makeKeyAndOrderFront(self)
        }
        return true
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ProjectLife")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving and Undo support

    @IBAction func saveAction(_ sender: AnyObject?) {
        // Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
        let context = persistentContainer.viewContext

        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing before saving")
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Customize this code block to include application-specific recovery steps.
                let nserror = error as NSError
                NSApplication.shared.presentError(nserror)
            }
        }
    }

    func windowWillReturnUndoManager(window: NSWindow) -> UndoManager? {
        // Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
        return persistentContainer.viewContext.undoManager
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        // Save changes in the application's managed object context before the application terminates.
        let context = persistentContainer.viewContext
        
        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing to terminate")
            return .terminateCancel
        }
        
        if !context.hasChanges {
            return .terminateNow
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError

            // Customize this code block to include application-specific recovery steps.
            let result = sender.presentError(nserror)
            if (result) {
                return .terminateCancel
            }
            
            let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?", comment: "Quit without saves error question message")
            let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save", comment: "Quit without saves error question info");
            let quitButton = NSLocalizedString("Quit anyway", comment: "Quit anyway button title")
            let cancelButton = NSLocalizedString("Cancel", comment: "Cancel button title")
            let alert = NSAlert()
            alert.messageText = question
            alert.informativeText = info
            alert.addButton(withTitle: quitButton)
            alert.addButton(withTitle: cancelButton)
            
            let answer = alert.runModal()
            if answer == .alertSecondButtonReturn {
                return .terminateCancel
            }
        }
        // If we got here, it is time to quit.
        return .terminateNow
    }

}

