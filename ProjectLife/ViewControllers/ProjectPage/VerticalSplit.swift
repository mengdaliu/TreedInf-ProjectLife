//
//  VerticalSplit.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/31.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class VerticalSplit: NSSplitViewController {
    
    static var instance : VerticalSplit?
    let minThickness = CGFloat((NSScreen.main?.frame.size.width)!/5)

    @IBOutlet weak var projectHierarchy: NSSplitView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.splitView.dividerStyle = .thin
        splitView.setValue(ColorGetter.getCurrentThemeColor(), forKey: "dividerColor")
       
        let root = RootPage.init(nibName: "RootPage", bundle: nil)
        let rootSplitItem = NSSplitViewItem.init(viewController: root)
        self.addSplitViewItem(rootSplitItem)
        rootSplitItem.minimumThickness = self.minThickness
        VerticalSplit.instance = self
    }

    
    
    override func mouseDown(with event: NSEvent) {
        print("hell no")
        self.view.window?.makeFirstResponder(nil)
    }
    
    
    func handleAddSplitItem(){
        let item = NSSplitViewItem.init(viewController: VerticalStack.init(nibName: "VerticalStack", bundle: nil))
        self.addSplitViewItem(item)
        item.minimumThickness = self.minThickness
        if self.splitViewItems.count >= 5 {
            self.splitViewItems[0].isCollapsed = true
        }
    }
    
    func handleLoadParentProject(){
        
    }
    func handleLoadSubProjects(){
        
    }
    
    func changeDividerColor(color : NSColor) {
        splitView.setValue(color, forKey: "dividerColor")
    }
}

