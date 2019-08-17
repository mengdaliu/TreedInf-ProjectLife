//
//  percentageAssertion.swift
//  ProjectLife
//
//  Created by 刘梦达 on 2019/8/18.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class percentageAssertion: NSViewController {
    @IBOutlet weak var secondLine: NSTextField!
    var forPlan = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        if !forPlan {
            self.secondLine.stringValue = "The percentage of a project that you completed on a day"
        }
    }
    
    @IBAction func pressOk(_ sender: Any) {
        self.dismiss(self)
        self.removeFromParent()
    }
}
