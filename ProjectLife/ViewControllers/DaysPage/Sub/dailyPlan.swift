//
//  dailyPlan.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/11.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class dailyPlan: NSViewController {

    @IBOutlet weak var scroll: NSScrollView!
    var stack : flippedView?
    
    @IBOutlet weak var plans: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        plans.stringValue = "Plans"
        plans.font = .labelFont(ofSize: 18)
        plans.textColor = ColorGetter.getCurrentThemeColor()
        
        let stack = flippedView.init(frame: scroll.documentView!.frame)
        self.stack = stack 
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.setClippingResistancePriority(.defaultLow, for: .vertical)
        scroll.documentView = stack
        scroll.drawsBackground = false
        scroll.borderType = .noBorder
        scroll.automaticallyAdjustsContentInsets = false
        
        stack.orientation = .vertical
        stack.alignment = .centerX
        stack.distribution = .gravityAreas
        stack.setHuggingPriority(.defaultLow, for: .vertical)
        stack.spacing = 5
        
        NSLayoutConstraint.init(item: stack, attribute: .leading, relatedBy: .equal, toItem: scroll, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: stack, attribute: .trailing, relatedBy: .equal, toItem: scroll, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: stack, attribute: .top, relatedBy: .equal, toItem: scroll, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        
        let ab = add.init(nibName: "add", bundle: nil)
        ab.set(for: "Plans")
        stack.addArrangedSubview(ab.view)
        self.addChild(ab)

    }
    
    
    func loadPlan(from data : [Plan]) {
        
    }
    
    func handleNewEdit(){
        let e = edit.init(nibName: "edit", bundle: nil)
        print(e)
        print(stack)
        print(stack?.arrangedSubviews)
        stack!.insertView(e.view, at: stack!.arrangedSubviews.count - 1, in: .top)
        self.addChild(e)
    }
}
