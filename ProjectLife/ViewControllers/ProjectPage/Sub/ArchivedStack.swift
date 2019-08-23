//
//  ArchivedStack.swift
//  ProjectLife
//
//  Created by 刘梦达 on 2019/8/21.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class ArchivedStack: NSViewController {

    @IBOutlet weak var scroll: NSScrollView!
    @IBOutlet weak var stack: flippedView!
    var expanded = false
    var parentP : Project!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        stack.orientation = .vertical
        stack.spacing = 15
        stack.alignment = .centerX
        
        let initialButton = ShowArchivedProjectsButton.init(nibName: "ShowArchivedProjectsButton", bundle: nil)
        initialButton.view.translatesAutoresizingMaskIntoConstraints = false 
        stack.addArrangedSubview(initialButton.view)
        self.addChild(initialButton)
    }
    
    
    
    
    func handleReactivateProject(item : projectStack) {
        self.handleRemoveProject(item: item)
        (self.parent as! VerticalStack).addProjectItem(VC: item)
        if self.stack.arrangedSubviews.count == 1 {
            (self.parent as! VerticalStack).handleRemove(deactivatedStack: self)
        }
    }
    
    func handleAddProjet(item : projectStack) {
       self.stack.insertArrangedSubview(item.view, at: 1)
       self.addChild(item)
    }
    
    
    func handleRemoveProject(item : projectStack) {
        self.stack!.removeView(item.view)
        item.removeFromParent()
    }
    
    
    func handleMoveUp(item : projectStack){
        var i = 0
        for ps in self.stack!.arrangedSubviews {
            if ps == item.view {
                //i is the index of item
                if i - 1 >= 1 {
                    self.stack?.removeView(item.view)
                    self.stack?.insertView(item.view, at: i - 1, in: .top)
                }
                break
            }
            i += 1
        }
    }
    
    
    
    func handleMoveDown(item : projectStack) {
        var i = 0
        for ps in self.stack!.arrangedSubviews {
            if ps == item.view {
                if !(i >= self.stack!.arrangedSubviews.count - 1) {
                    self.stack?.removeView(item.view)
                    self.stack?.insertView(item.view, at: i + 1, in: .top)
                }
                break
            }
            i += 1
        }
    }
    
    func handleToggle(){
        if expanded {
            handleCollapse()
            expanded = false
        } else {
            handleExpand()
            expanded = true 
        }
    }
    
    
    func handleExpand() {
        for item in Array(self.parentP.archivedSubProjects ?? []) {
            let newPStack = projectStack.init(nibName: "projectStack", bundle: nil)
            self.handleAddProjet(item: newPStack)
            newPStack.setTitle(title: (item as! Project).title ?? "")
            newPStack.p = (item as! Project)
        }
    }
    
    func handleCollapse() {
        var i = 0
        for v in self.stack.arrangedSubviews {
            if i != 0 {
                self.stack.removeView(v)
            }
            i += 1
        }
    }
}
