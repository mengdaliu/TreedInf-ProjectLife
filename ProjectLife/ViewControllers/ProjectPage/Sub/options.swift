//
//  options.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/15.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class options: NSViewController {

    @IBOutlet weak var plan: HoverButton!
    @IBOutlet weak var work: HoverButton!
    @IBOutlet weak var archive: HoverButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = .init(gray: 0.9, alpha: 0.8)
        plan.translatesAutoresizingMaskIntoConstraints = false
        plan.font = .labelFont(ofSize: 18)
        plan.showsBorderOnlyWhileMouseInside = true
        work.translatesAutoresizingMaskIntoConstraints = false
        work.font = .labelFont(ofSize: 18)
        work.showsBorderOnlyWhileMouseInside = true
        archive.translatesAutoresizingMaskIntoConstraints = false
        archive.font = .labelFont(ofSize: 18)
        archive.showsBorderOnlyWhileMouseInside = true 
        plan.setText(str: "Plan For Day", color: ThemeColor.red)
        work.setText(str: "Record Work For Day", color: ThemeColor.green)
        archive.setText(str: "Archive", color: ThemeColor.blue)
    }
    
}
