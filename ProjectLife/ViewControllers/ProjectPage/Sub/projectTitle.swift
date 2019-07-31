//
//  projectTitle.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/31.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class projectTitle: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        NSLayoutConstraint.init(item: self.T, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
        //NSLayoutConstraint.init(item: self.T, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: -50).isActive = true
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = ThemeColor.blue.cgColor
        self.view.layer?.masksToBounds = true
        self.view.layer?.cornerRadius = 10
        T.font = .labelFont(ofSize: 20)
        T.alignment = .center
        T.drawsBackground = true
        T.backgroundColor = ThemeColor.blue
        T.textColor = .white
        
    }
    
    @IBOutlet weak var T: RoundedTextFieldCell!
    @IBAction func handleTitleEnter(_ sender: NSTextField) {
        
    }
}
