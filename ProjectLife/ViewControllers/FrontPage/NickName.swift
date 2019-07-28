//
//  NickName.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/23.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class NickName: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        greetingLine.font = .labelFont(ofSize: 50)
        nameField.font = .labelFont(ofSize: 50)
        nameField.isBezeled = false
        nameField.focusRingType = .none
        let lineView = lineDrawer.init()
        
        lineView.setFrameSize(nameField.frame.size)
        self.view.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.init(item: lineView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: lineView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.3, constant: -15).isActive = true
        NSLayoutConstraint.init(item: lineView, attribute: .width, relatedBy: .equal, toItem: self.nameField, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: lineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100).isActive = true
    }
    
  
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var greetingLine: NSTextField!
    
    
    
    

}







