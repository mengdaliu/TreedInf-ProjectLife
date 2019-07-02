//
//  MasterWindowController.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/2.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class MasterWindowController: NSWindowController {
    
    let userDefaults = UserDefaults.init()
    var color : NSColor {
        get {
            let loadedData = UserDefaults.standard.data(forKey: "color")
            var loadedColor : NSColor?
            do {try loadedColor =  NSKeyedUnarchiver.unarchivedObject(ofClasses : [NSColor.self], from: loadedData!) as? NSColor
            } catch {
                return NSColor.init()
            }
            return loadedColor ?? NSColor.init()
        }
        set {
            self.window?.backgroundColor = color
        }
    }
    override func windowDidLoad() {
        super.windowDidLoad()
        

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        self.window?.titlebarAppearsTransparent = true
        self.window?.backgroundColor = NSColor.black
        self.window?.titleVisibility = .hidden
        self.window?.styleMask.insert(.fullSizeContentView)
    }

    
    
}
