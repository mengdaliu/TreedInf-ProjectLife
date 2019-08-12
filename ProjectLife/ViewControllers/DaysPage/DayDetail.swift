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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.splitView.dividerStyle = .thin
        splitView.setValue(ColorGetter.getCurrentThemeColor(), forKey: "dividerColor")
        
        let smallConstraint = NSLayoutConstraint.init(item: self.view, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        let largeConstraint = NSLayoutConstraint.init(item: self.view, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: NSScreen.main!.frame.height - 300)
        smallConstraint.isActive = true
        
        
        let plan = NSSplitViewItem.init(viewController : dailyPlan.init(nibName: "dailyPlan", bundle: nil))
        let done = NSSplitViewItem.init(viewController: dailyDone.init(nibName: "dailyDone", bundle: nil))
        self.addSplitViewItem(plan)
        self.addSplitViewItem(done)
    }
    
    
}
