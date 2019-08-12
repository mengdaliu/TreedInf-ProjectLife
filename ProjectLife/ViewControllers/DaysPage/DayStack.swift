//
//  DayStack.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/11.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class DayStack: NSViewController {

    @IBOutlet weak var stack: flippedView!
    var day : Day?
    var dTitle : DayTitle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let title = DayTitle.init(nibName: "DayTitle", bundle: nil)
        self.stack.addArrangedSubview(title.view)
        self.addChild(title)
        self.dTitle = title
    }
    
    func setDay(day : Day) {
        self.day = day
        self.dTitle!.setDate(date: day.date!)
    }
}
