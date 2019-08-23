//
//  ShowArchivedProjectsButton.swift
//  ProjectLife
//
//  Created by 刘梦达 on 2019/8/21.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class ShowArchivedProjectsButton: NSViewController {

    @IBOutlet weak var button: HoverButton!
    var show = true 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        button.bezelStyle = .regularSquare
        button.font = .labelFont(ofSize: 20)
        button.wantsLayer = true
        button.layer?.backgroundColor = .init(red: 0.87, green: 0.8, blue: 0.74, alpha: 0.95)
        button.showsBorderOnlyWhileMouseInside  = true
        button.layer?.masksToBounds =  true
        button.layer?.cornerRadius = 20
    }
    
    
    @IBAction func toggle(_ sender: Any) {
        if show {
            button.setText(str: "Hide Archived Projects", color: ThemeColor.black)
            show = false
        } else {
            button.setText(str: "Show Archived Projects", color: ThemeColor.black)
            show = true
        }
        (self.parent as! ArchivedStack).handleToggle()
    }
}
