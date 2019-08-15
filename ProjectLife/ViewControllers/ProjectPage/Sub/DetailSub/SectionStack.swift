//
//  SectionStack.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/15.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class SectionStack: NSViewController {

    @IBOutlet weak var Stack: flippedView!
    var sTitle : SectionTitle!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    func addTitle(titleVC : SectionTitle) {
        self.Stack.addArrangedSubview(titleVC.view)
        self.addChild(titleVC)
        self.sTitle = titleVC
    }
    
    func expandAndEditOverview() {
        self.sTitle.expandAndEditOverview() 
    }
    
}
