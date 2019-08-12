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
    
    @IBOutlet weak var products: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

        products.font = .labelFont(ofSize: 18)
        products.stringValue = "Products"
        products.textColor = ColorGetter.getCurrentThemeColor()
        
        let stack = flippedView.init(frame: scroll.documentView!.frame)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .centerX
        
        scroll.documentView = stack
        scroll.drawsBackground = false
        NSLayoutConstraint.init(item: stack, attribute: .leading, relatedBy: .equal, toItem: scroll, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: stack, attribute: .trailing, relatedBy: .equal, toItem: scroll, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        
        let ab = add.init(nibName: "add", bundle: nil)
        ab.set(for: "Dones")
        stack.addArrangedSubview(ab.view)
        self.addChild(ab)
    }
    
    func loadDone(from data : [Done]) {
        
    }
    
}

