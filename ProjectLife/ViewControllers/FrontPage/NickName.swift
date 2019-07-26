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
        
       
        lineView.frame = .init(origin: NSPoint.init(x: nameField.frame.minX, y: nameField.frame.minY), size: CGSize.init(width: nameField.frame.width, height: nameField.frame.height))
        
        
        
        
    }
  
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var greetingLine: NSTextField!
    
    @IBOutlet weak var lineView: lineDrawer!
    
    
    

}







