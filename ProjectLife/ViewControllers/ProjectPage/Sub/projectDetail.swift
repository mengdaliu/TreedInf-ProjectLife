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
    @IBOutlet weak var Stack: flippedView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: Stack, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0).isActive = true
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = .init(CGColor.init(gray: 0.9, alpha: 1))
        smallConstraint = NSLayoutConstraint.init(item: self.view, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        largeConstraint = NSLayoutConstraint.init(item: self.view, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: NSScreen.main!.frame.height - 300)
        //NSLayoutConstraint.init(item: Stack, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0).isActive = true
        smallConstraint?.isActive = true
        Stack.wantsLayer = true
    
        //NSLayoutConstraint.init(item: stack, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0).isActive = true
        let Section = SectionTitle.init(nibName: "SectionTitle", bundle: nil)
        
        
        //print(description.view)
        Stack.addArrangedSubview(Section.view)
        Section.setTitle(title: "Description")
        Section.setStack(stack: Stack)
        self.addChild(Section)
        //self.presentAsSheet(description)
      
        
        
        let doubleTap  = NSClickGestureRecognizer.init(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfClicksRequired = 2
        doubleTap.isEnabled = true
        doubleTap.delaysPrimaryMouseButtonEvents = false
        self.view.addGestureRecognizer(doubleTap)
    }
    
    @objc func handleDoubleTap() {
        if smallConstraint!.isActive {
            smallConstraint?.isActive = false
            largeConstraint?.isActive = true
        } else {
            largeConstraint?.isActive = false
            smallConstraint?.isActive = true
        }
    }
}
