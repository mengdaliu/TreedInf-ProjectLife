//
//  addButton.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/5.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class addButton: NSViewController {

    @IBOutlet weak var button: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        button.bezelStyle = .regularSquare
        button.font = .labelFont(ofSize: 20)
        button.wantsLayer = true
        button.layer?.backgroundColor = .init(red: 240, green: 256, blue: 240, alpha: 0.8)
        button.layer?.masksToBounds =  true
        button.layer?.cornerRadius = 20
    }
    
    @IBAction func add(_ sender: NSButtonCell) {
        (self.parent! as! VerticalStack).addProjectItem()
    }
    
}
