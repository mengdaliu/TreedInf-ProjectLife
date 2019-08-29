//
//  DayDetail.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/11.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class DayDetail: NSSplitViewController {
    
    var smallConstraint : NSLayoutConstraint?
    var largeConstraint : NSLayoutConstraint?
    var plan : dailyPlan?
    var done : dailyDone?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.splitView.dividerStyle = .thin
        splitView.setValue(ColorGetter.getCurrentThemeColor(), forKey: "dividerColor")
        
        self.smallConstraint = NSLayoutConstraint.init(item: self.view, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        self.largeConstraint = NSLayoutConstraint.init(item: self.view, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: NSScreen.main!.frame.height - 300)
        smallConstraint!.isActive = true
        
        
        let plan = NSSplitViewItem.init(viewController : dailyPlan.init(nibName: "dailyPlan", bundle: nil))
        let done = NSSplitViewItem.init(viewController: dailyDone.init(nibName: "dailyDone", bundle: nil))
        self.plan = (plan.viewController as! dailyPlan)
        self.done = (done.viewController as! dailyDone)
        self.addSplitViewItem(plan)
        self.addChild(plan.viewController)
        self.addSplitViewItem(done)
        self.addChild(done.viewController)
    }
    
    override func rightMouseDown(with event: NSEvent) {
        if smallConstraint!.isActive {
            smallConstraint?.isActive = false
            largeConstraint?.isActive = true
            self.plan?.scroll.allowScroll = true
            self.done?.scroll.allowScroll = true
        } else {
            largeConstraint?.isActive = false
            smallConstraint?.isActive = true
            self.plan?.scroll.allowScroll = false
            self.done?.scroll.allowScroll = false
        }
    }
    
}
