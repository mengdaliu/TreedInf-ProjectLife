//
//  VerticalSplit.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/31.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class VerticalSplit: NSSplitViewController {
    
    static var instance : NSSplitViewController?

    @IBOutlet weak var projectHierarchy: NSSplitView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        VerticalSplit.instance = self
        self.splitView.dividerStyle = .thin
        splitView.setValue(ColorGetter.getCurrentThemeColor(), forKey: "dividerColor")
        print(self.splitView.dividerColor)
        let testVC = VerticalStack.init(nibName: "VerticalStack", bundle: nil)
        let testSplitItem = NSSplitViewItem.init(viewController: testVC)
        self.addSplitViewItem(testSplitItem)
        let testVC2 = VerticalStack.init(nibName: "VerticalStack", bundle: nil)
        let testSplitItem2 = NSSplitViewItem.init(viewController: testVC2)
        self.addSplitViewItem(testSplitItem2)
        let testVC3 = VerticalStack.init(nibName: "VerticalStack", bundle: nil)
        let testSplitItem3 = NSSplitViewItem.init(viewController: testVC3)
        self.addSplitViewItem(testSplitItem3)
        let testVC4 = VerticalStack.init(nibName: "VerticalStack", bundle: nil)
        let testSplitItem4 = NSSplitViewItem.init(viewController: testVC4)
        self.addSplitViewItem(testSplitItem4)
        let testVC5 = VerticalStack.init(nibName: "VerticalStack", bundle: nil)
        let testSplitItem5 = NSSplitViewItem.init(viewController: testVC5)
        self.addSplitViewItem(testSplitItem5)
    }
}

