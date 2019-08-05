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
    var stack : NSStackView?
    var level : Int?
    var items : Int =  -1
    var expandedDetails : [Int]?
    var add : addButton!
    
    @IBOutlet weak var test: NSButton!

    //@IBOutlet weak var ProjectStack: NSStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let ProjectStack = flippedView.init(frame: scroll.documentView!.frame)
        ProjectStack.orientation = .vertical
        ProjectStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        //self.scroll.addSubview(ProjectStack)
        self.scroll.documentView = ProjectStack
        ProjectStack.setClippingResistancePriority(.defaultLow, for: .vertical)
        let add = addButton.init(nibName: "addButton", bundle: nil)
        ProjectStack.addArrangedSubview(add.view)
        self.addChild(add)
        self.add = add 

    
       // NSLayoutConstraint.init(item: ProjectStack, attribute: .height, relatedBy: .equal, toItem: scroll, attribute: .height, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: ProjectStack, attribute: .leading, relatedBy: .equal, toItem: scroll, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: ProjectStack, attribute: .trailing, relatedBy: .equal, toItem: scroll, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        //scroll.addFloatingSubview(ProjectStack, for: .vertical)
        scroll.drawsBackground = false
        scroll.borderType = .noBorder
        scroll.automaticallyAdjustsContentInsets = false
        
        
        //scroll.addFloatingSubview(ProjectStack, for: .horizontal)
        
       
       
        ProjectStack.alignment = .centerX
        ProjectStack.distribution = .gravityAreas
        ProjectStack.setHuggingPriority(.defaultLow, for: .vertical)
        ProjectStack.spacing = 15
       
        
        
       self.stack = ProjectStack
        
      
    }
    
    func setLevel(level : Int){
        self.level = level
    }
    
    func addProjectItem() {
        self.items = self.items + 1
        let item = projectStack.init(nibName: "projectStack", bundle: nil)
        self.stack!.insertView(item.view, at: self.stack!.arrangedSubviews.count - 1, in: .top)
        self.addChild(item)
        
    }
    
    func addProjectItem(VC : projectStack) {
        self.items = self.items + 1
        self.stack!.insertView(VC.view, at: self.stack!.arrangedSubviews.count - 1, in: .top)
        self.addChild(VC)
    }
    
    
}

class flippedView : NSStackView {
    override var isFlipped: Bool  {
        return true
    }
}
