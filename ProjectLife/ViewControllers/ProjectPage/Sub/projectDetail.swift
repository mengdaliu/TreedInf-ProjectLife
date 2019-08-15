//
//  ProjectDetail.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/2.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class projectDetail: NSViewController {
    var smallConstraint : NSLayoutConstraint?
    var largeConstraint : NSLayoutConstraint?
    var expanded = false
    var overview : SectionStack!
    var expandedSectionDetails = [NSViewController].init()
    @IBOutlet weak var Stack: flippedView!
    @IBOutlet weak var scroll: NSScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let stack = flippedView.init()
        self.Stack = stack
        Stack.translatesAutoresizingMaskIntoConstraints = false
        scroll.documentView = stack
        scroll.drawsBackground = false
        scroll.borderType = .noBorder
        NSLayoutConstraint.init(item: Stack!, attribute: .leading, relatedBy: .equal, toItem: self.scroll, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: Stack!, attribute: .trailing, relatedBy: .equal, toItem: self.scroll, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = .init(CGColor.init(gray: 0.9, alpha: 1))
        smallConstraint = NSLayoutConstraint.init(item: self.view, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        largeConstraint = NSLayoutConstraint.init(item: self.view, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: NSScreen.main!.frame.height - 300)
        //NSLayoutConstraint.init(item: Stack, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0).isActive = true
        smallConstraint?.isActive = true
        Stack.wantsLayer = true
    
        //NSLayoutConstraint.init(item: stack, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0).isActive = true
        let overViewStack = SectionStack.init(nibName: "SectionStack", bundle: nil)
        self.Stack.addArrangedSubview(overViewStack.view)
        self.addChild(overViewStack)
        let Section = SectionTitle.init(nibName: "SectionTitle", bundle: nil)
        overViewStack.addTitle(titleVC: Section)
        
        //print(description.view)
        Section.setTitle(title: "Overview")
        overview = overViewStack
        //self.presentAsSheet(description)
      
        
        
        let doubleTap  = NSClickGestureRecognizer.init(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfClicksRequired = 2
        //doubleTap.isEnabled = true
        //doubleTap.delaysPrimaryMouseButtonEvents = false
        //self.view.addGestureRecognizer(doubleTap)
    }
    
    override func rightMouseDown(with event: NSEvent) {
        if !expanded {
           expand()
        } else {
           collapse()
            for item in self.expandedSectionDetails {
                item.collapse()
            }
        }
    }
    
    @objc override func expand(){
        expanded = true
        smallConstraint?.isActive = false
        largeConstraint?.isActive = true
    }
    
    @objc override func collapse(){
        expanded = false
        largeConstraint?.isActive = false
        smallConstraint?.isActive = true
    }
    
    @objc func handleDoubleTap() {
        
    }
    
    func handleExpandOverview(){
        self.overview!.expandAndEditOverview()
    }
}
