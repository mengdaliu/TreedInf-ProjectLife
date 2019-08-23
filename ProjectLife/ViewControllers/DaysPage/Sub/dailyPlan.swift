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
        plans.font = .labelFont(ofSize: 20)
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
    }
    
    override func viewDidAppear() {
        let plans =  day.getPlan(from: (self.parent?.parent as! DayStack).day!)
        for plan in plans ?? [] {
            let pVC = singlePlan.init(nibName : "singlePlan", bundle : nil)
            pVC.config(plan : plan, project: plan.project!, percent: plan.percentage, comment: plan.comment)
            self.stack?.addArrangedSubview(pVC.view)
            self.addChild(pVC)
        }
    }
    
    
    func loadPlan(from data : [Plan]) {
        
    }
    
    func handleNewEdit(){
        let e = edit.init(nibName: "edit", bundle: nil)
        stack!.insertView(e.view, at: stack!.arrangedSubviews.count - 1, in: .top)
        self.addChild(e)
    }
}
