//
//  optionWrapper.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/15.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class optionWrapper: NSViewController {

    @IBOutlet weak var optionBox: NSBox!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        optionBox.borderType = .noBorder    
        
    }
    
    func setUpForActiveProject(){
        let optionVC = options.init(nibName: "options", bundle : nil)
        self.addChild(optionVC)
        optionBox.contentView = optionVC.view
    }
    
    func setUpForDeactivatedProject(){
        let optionVC = reactivate.init(nibName: "reactivate", bundle : nil)
        optionBox.contentView = optionVC.view
        self.addChild(optionVC)
    }
    
}
