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
    
    override func windowDidLoad() {
        super.windowDidLoad()
        

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        self.window?.titlebarAppearsTransparent = true
        self.window?.titleVisibility = .hidden
        self.window?.styleMask.insert(.fullSizeContentView)
        self.window?.setIsZoomed(true)
    }

    
    
}
