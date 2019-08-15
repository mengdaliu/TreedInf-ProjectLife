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
    
    
    func handleLoadChildren(for proj : projectStack) -> VerticalStack {
        let current = (proj.parent as! VerticalStack).unSelectCurrent(proj : proj)
        removeChildren(current: current)
        
        var newStackVC : VerticalStack
        var item: NSSplitViewItem
        
        newStackVC = VerticalStack.init(nibName: "VerticalStack", bundle: nil)
        proj.childrenVC = newStackVC
        newStackVC.parentProj = proj.p
        newStackVC.parentVC = proj.parent as? VerticalStack
        item = NSSplitViewItem.init(viewController: newStackVC)
        self.addSplitViewItem(item)
        if proj.p.subProjects != nil {
            generateStackView(from: Array(proj.p!.subProjects!) as! [Project], in: newStackVC)
        }
    
        
        item.minimumThickness = self.minThickness
        item.maximumThickness  = self.maxThickness

        if self.splitViewItems.count >= 6 {
            self.removeSplitViewItem(self.splitViewItems[0])
            (self.splitViewItems[0].viewController as! VerticalStack).hasParentLoaded = false
            (self.splitViewItems[0].viewController as! VerticalStack).rightButton.isEnabled = false 
        }
        (proj.parent as? VerticalStack)?.hasChildrenRemoved = false
        (proj.parent as? VerticalStack)?.leftButton.isEnabled = true
        return newStackVC
    }
    
    func handleLoadParentProject(for vStack : VerticalStack){
        self.insertSplitViewItem(NSSplitViewItem.init(viewController : vStack.parentVC!), at: 0)
        vStack.parentVC?.hasParentLoaded = false 
        if self.splitViewItems.count >= 6 {
            self.removeSplitViewItem(self.splitViewItems[self.splitViewItems.count - 1])
            let newLast = self.splitViewItems[self.splitViewItems.count - 1].viewController as! VerticalStack
            newLast.hasChildrenRemoved = true
            newLast.rightButton.isEnabled = false 
            (self.splitViewItems[self.splitViewItems.count-1].viewController as! VerticalStack).hasChildrenRemoved = true
            (self.splitViewItems[self.splitViewItems.count-1].viewController as! VerticalStack).leftButton.isEnabled = false
        }
    }
    
    func generateStackView(from subProjects : [Project], in stack : VerticalStack){
        for project in subProjects {
            let projStack = projectStack.init(nibName: "projectStack", bundle: nil)
            stack.addProjectItem(VC: projStack)
            projStack.setTitle(title: project.title ?? "")
            projStack.p = project
        }
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
    
    func handleMoveToParentLevel(proj : projectStack) {
        (proj.parent as! VerticalStack).stack!.removeView(proj.view)
        var i = 0
        var last : NSViewController?
        var parent : VerticalStack
        for item in self.splitViewItems {
            if item.viewController == proj.parent {
                if last == nil {
                    handleLoadParentProject(for: item.viewController as! VerticalStack)
                    parent = (self.splitViewItems[0].viewController as! VerticalStack)
                } else {
                    parent = (self.splitViewItems[i - 1].viewController as! VerticalStack)
                }
                parent.addProjectItem(VC: proj)
                break
            }
            i += 1
            last = item.viewController
        }
        
    }
    
    func handleMove(proj : projectStack, toChildLevelOf otherProj : projectStack) {
        (proj.parent as! VerticalStack).stack!.removeView(proj.view)
        otherProj.childrenVC!.addProjectItem(VC: proj)
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

