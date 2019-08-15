//
//  VerticalStack.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/31.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class VerticalStack: NSViewController {


    @IBOutlet weak var scroll: NSScrollView!
    @IBOutlet weak var parentName: NSTextField!
    
    var stack : NSStackView?
    var level : Int?
    var items : Int =  -1
    var expandedDetails : [Int]?
    var add : addButton!
    var parentVC : VerticalStack?
    var parentProj : Project?
    var selected : projectStack?
    var hasParentLoaded = true
    var hasChildrenRemoved = true
    
    
    @IBOutlet weak var test: NSButton!

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let ProjectStack = flippedView.init(frame: scroll.documentView!.frame)
        ProjectStack.orientation = .vertical
        ProjectStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        self.scroll.documentView = ProjectStack
        ProjectStack.setClippingResistancePriority(.defaultLow, for: .vertical)
        let add = addButton.init(nibName: "addButton", bundle: nil)
        ProjectStack.addArrangedSubview(add.view)
        self.addChild(add)
        self.add = add 

    
        NSLayoutConstraint.init(item: ProjectStack, attribute: .leading, relatedBy: .equal, toItem: scroll, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: ProjectStack, attribute: .trailing, relatedBy: .equal, toItem: scroll, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        scroll.drawsBackground = false
        scroll.borderType = .noBorder
        scroll.automaticallyAdjustsContentInsets = false
        
        parentName.stringValue = self.parentProj?.title ?? ""
        parentName.font = .labelFont(ofSize: 20)
        parentName.textColor = ColorGetter.getCurrentThemeColor()
        
       
       
        ProjectStack.alignment = .centerX
        ProjectStack.distribution = .gravityAreas
        ProjectStack.setHuggingPriority(.defaultLow, for: .vertical)
        ProjectStack.spacing = 15
       
        leftButton.isEnabled = false
        rightButton.isEnabled = true
        
        
       self.stack = ProjectStack
        
      
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        parentName.stringValue = self.parentProj?.title ?? ""
        if self.hasParentLoaded {
            self.rightButton.isEnabled = true
        } else {
            self.rightButton.isEnabled = false
        }
        
        if !self.hasParentLoaded || !self.hasChildrenRemoved {
            self.leftButton.isEnabled = true
        } else {
            self.leftButton.isEnabled = false 
        }
    }
    

    @IBOutlet weak var clipp: NSClipView!
    func addProjectItem() {
        self.items = self.items + 1
        let item = projectStack.init(nibName: "projectStack", bundle: nil)
        self.stack!.insertView(item.view, at: self.stack!.arrangedSubviews.count - 1, in: .top)
        let newProj = project.newProject(for: self.parentProj!, title: "")
        item.p = newProj
        item.pTitle.setPosition(at: self.items)
        self.addChild(item)
        self.scroll!.scroll(clipp, to: .init(x: self.stack!.frame.origin.x, y: self.stack!.frame.origin.y + self.stack!.frame.height))
        moveHelperGlobal.projectTitleListening = item.pTitle
    }
    
    func addProjectItem(VC : projectStack) {
        self.items = self.items + 1
        self.stack!.insertView(VC.view, at: self.stack!.arrangedSubviews.count - 1, in: .top)
        self.addChild(VC)
    }

    @IBOutlet weak var leftButton: NSButton!
    @IBOutlet weak var rightButton: NSButton!
    
   
    @IBAction func handleRight(_ sender: NSButton) {
        if hasParentLoaded {
             VerticalSplit.instance!.handleCollapseParents(for : self)
             hasParentLoaded = false
        }
        sender.isEnabled = false
        self.leftButton.isEnabled = true 
    }
    
    @IBAction func handleLeft(_ sender: NSButton) {
        if !hasParentLoaded {
            VerticalSplit.instance!.handleLoadParentProject(for: self)
            self.rightButton.isEnabled = true
            hasParentLoaded = true
            if hasChildrenRemoved {
                sender.isEnabled = false
            }
        } else if !hasChildrenRemoved {
            removeChildrenHelper()
        }
    }
    
    func removeChildrenHelper(){
        VerticalSplit.instance!.removeChildren(current: self)
        if self.selected != nil {
            self.selected?.returnNormal()
            self.selected?.pTitle.loadedChildren = false
        }
        hasChildrenRemoved = true
        self.leftButton.isEnabled = false
    }
    
    
    func unSelectCurrent(proj : projectStack) -> VerticalStack? {
        if self.selected != nil  {
            self.selected!.returnNormal()
            self.selected = proj
            return self
        }
        self.selected = proj
        return nil
    }
    
    func handleDelete(item : projectStack) {
        item.removeFromParent()
        self.stack?.removeView(item.view)
        project.delete(proj: item.p)
    }
    
    func handleMoveUp(item : projectStack){
        var i = 0
        print("here")
        for ps in self.stack!.arrangedSubviews {
            if ps == item.view {
                //i is the index of item
                if i - 1 >= 0 {
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
                if !(i >= self.stack!.arrangedSubviews.count - 2) {
                    self.stack?.removeView(item.view)
                    self.stack?.insertView(item.view, at: i + 1, in: .top)
                }
                break
            }
            i += 1
        }
        
    }
}


class flippedView : NSStackView {
    override var isFlipped: Bool  {
        return true
    }
}
