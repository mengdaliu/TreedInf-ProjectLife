//
//  trivialLine.swift
//  ProjectLife
//
//  Created by 刘梦达 on 2019/8/26.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class trivialLine: NSViewController {

    @IBOutlet weak var line: RoundedTextFieldCell!
    @IBOutlet weak var T: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        line.isEnabled = false
        line.isBordered = false
        line.backgroundColor = NSColor.init(cgColor : CGColor.init(gray: 0.92, alpha: 0))!
        NSLayoutConstraint.init(item: T, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 1).isActive = true
    }
}
