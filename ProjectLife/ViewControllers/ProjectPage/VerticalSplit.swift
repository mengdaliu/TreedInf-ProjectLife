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
    let maxThickness = CGFloat((NSScreen.main?.frame.size.width)!)

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
        rootSplitItem.maximumThickness = self.maxThickness
        rootSplitItem.collapseBehavior = .preferResizingSplitViewWithFixedSiblings
        VerticalSplit.instance = self
    }

    
    
    override func mouseDown(with event: NSEvent) {
        self.view.window?.makeFirstResponder(nil)
    }
    
    
    func handleLoadChildren(for proj : projectStack) {
        
        var newStackVC : VerticalStack
        if proj.childrenVC != nil {
            newStackVC = proj.childrenVC as! VerticalStack
        } else if proj.p.subProjects != nil {
            newStackVC = generateStackView(from: Array(proj.p.subProjects!) as! [Project])
            proj.childrenVC = newStackVC
        } else {
            newStackVC = VerticalStack.init(nibName: "VerticalStack", bundle: nil)
        }
        
        newStackVC.parentProj = proj.p
        newStackVC.parentVC = proj.parent as? VerticalStack
        let item = NSSplitViewItem.init(viewController: newStackVC)
        
        let current = (proj.parent as! VerticalStack).unSelectCurrent(proj : proj)
        removeChildren(current: current)
        
        self.addSplitViewItem(item)
        self.splitViewItems[self.splitViewItems.count - 2].minimumThickness = self.minThickness
        item.minimumThickness = self.maxThickness - self.minThickness * CGFloat((self.splitViewItems.count - 1))
        item.maximumThickness  = self.maxThickness
        self.splitViewItems[self.splitViewItems.count-2].collapseBehavior = .preferResizingSplitViewWithFixedSiblings
        self.splitViewItems[self.splitViewItems.count-2].isCollapsed = true
        self.splitViewItems[self.splitViewItems.count - 2].isCollapsed = false
        item.collapseBehavior = .preferResizingSiblingsWithFixedSplitView
        if self.splitViewItems.count >= 6 {
            self.removeSplitViewItem(self.splitViewItems[0])
        }
        
        (proj.parent as? VerticalStack)?.hasChildrenRemoved = false
        (proj.parent as? VerticalStack)?.leftButton.isEnabled = true
    }
    
    func handleLoadParentProject(for vStack : VerticalStack){
        self.insertSplitViewItem(NSSplitViewItem.init(viewController : vStack.parentVC!), at: 0)
        vStack.parentVC?.hasParentLoaded = false 
        if self.splitViewItems.count >= 6 {
            self.removeSplitViewItem(self.splitViewItems[self.splitViewItems.count - 1])
            let newLast = self.splitViewItems[self.splitViewItems.count - 1].viewController as! VerticalStack
            newLast.hasChildrenRemoved = true
            newLast.rightButton.isEnabled = false 
            
        }
    }
    
    func generateStackView(from subProjects : [Project]) -> VerticalStack {
        let stack = VerticalStack.init(nibName: "VerticalStack", bundle: nil)
        for project in subProjects {
            let projStack = projectStack.init(nibName: "ProjectStack", bundle: nil)
            projStack.setTitle(title: project.title ?? "")
            projStack.p = project
            stack.addProjectItem(VC: projStack)
        }
        return stack
    }
    
    func handleCollapseParents(for VC : VerticalStack) {
        for item in self.splitViewItems {
            if item.viewController != VC  {
                if item.viewController != RootPage.instance! {
                    (item.viewController as! VerticalStack).hasParentLoaded = false
                }
                 self.removeSplitViewItem(item)
            } else {
                break
            }
        }
    }
    
    func changeDividerColor(color : NSColor) {
        splitView.setValue(color, forKey: "dividerColor")
    }
    
    func removeChildren(current : VerticalStack?) {
        if current != nil {
            var met = false
            for item in self.splitViewItems {
                if item.viewController == current {
                    met = true
                } else if met {
                    self.removeSplitViewItem(item)
                }
            }
        }
    }
}

