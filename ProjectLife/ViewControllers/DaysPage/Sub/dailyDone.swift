//
//  dailyDone.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/11.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class dailyDone: NSViewController {

    @IBOutlet weak var scroll: NSScrollView!
    var stack : flippedView!
    @IBOutlet weak var products: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

        products.font = .labelFont(ofSize: 20)
        products.stringValue = "Products"
        products.textColor = ColorGetter.getCurrentThemeColor()
        
        self.stack = flippedView.init(frame: scroll.documentView!.frame)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .centerX
        
        scroll.documentView = stack
        scroll.drawsBackground = false
        NSLayoutConstraint.init(item: stack, attribute: .leading, relatedBy: .equal, toItem: scroll, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: stack, attribute: .trailing, relatedBy: .equal, toItem: scroll, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
    }
    
    
    override func viewDidAppear() {
        let dones =  day.getDone(from: (self.parent?.parent as! DayStack).day!)
        for done in dones ?? [] {
            let dVC = singleDone.init(nibName : "singleDone", bundle : nil)
            dVC.config(done : done, project: done.project!, percent: done.percentage, comment: done.comment)
            self.stack?.addArrangedSubview(dVC.view)
            self.addChild(dVC)
        }
    }
    
    func loadDone(from data : [Done]) {
        
    }
    
}

