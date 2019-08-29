//
//  History.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/2.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class HistoryContentScroll: NSViewController {

    @IBOutlet weak var scroll: NSScrollView!
    @IBOutlet var historyTextView: NSTextView!
    var p : Project?
    var Stack : flippedView!
    
    var smallConstraint : NSLayoutConstraint!
    var largeConstraint : NSLayoutConstraint!
    var expanded = false 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let stack = flippedView.init(frame: self.scroll.frame)
        scroll.documentView = stack
        self.Stack = stack
        stack.translatesAutoresizingMaskIntoConstraints = false 
        NSLayoutConstraint.init(item: stack, attribute: .leading, relatedBy: .equal, toItem: scroll, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: stack, attribute: .trailing, relatedBy: .equal, toItem: scroll, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        
        stack.spacing = 1
        stack.orientation = .vertical
        stack.alignment = .leading
        Stack.setContentHuggingPriority(.defaultLow, for: .vertical)
        Stack.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        self.smallConstraint = NSLayoutConstraint.init(item: self.view, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 75)
        self.largeConstraint = NSLayoutConstraint.init(item: self.view, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: NSScreen.main!.frame.height - 350)
        if !self.largeConstraint.isActive {
            self.smallConstraint.isActive = true
        }
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.drawsBackground = false

    }
    
    override func viewDidAppear() {
        if self.p != nil {
            for v in self.Stack.arrangedSubviews {
                self.Stack.removeView(v)
            }
            loadHistory()
        }
    }
    
    func setProject(project : Project) {
        self.p = project
    }

    
    func loadHistory(){
        let history = projectHistory.loadHistory(for: self.p!)
        
       // self.Stack.addArrangedSubview(addButton.init(nibName: "addButton", bundle: nil).view)
        if history != nil {
            for singleDay in history! {
                let single = singleDayHistory.init(nibName: "singleDayHistory", bundle: nil)
                single.setHistory(history: singleDay)
                single.view.translatesAutoresizingMaskIntoConstraints = false 
                self.Stack.addArrangedSubview(single.view)
                self.addChild(single)
            }
        }
       
    }
    
    override func rightMouseDown(with event: NSEvent) {
        if !expanded {
            expand()
            if !(self.parent!.parent as! projectDetail).expanded {
                (self.parent!.parent as! projectDetail).expand()
            }
        } else {
            collapse()
        }
    }
    
    
    @objc override func expand(){
        expanded = true
        self.smallConstraint.isActive = false
        self.largeConstraint.isActive = true
        (self.parent!.parent as! projectDetail).expandedSectionDetails.append(self)
    }
    
    @objc override func collapse(){
        expanded = false
        self.largeConstraint.isActive = false
        self.smallConstraint.isActive = true
        var i = 0
        for item in (self.parent!.parent as! projectDetail).expandedSectionDetails {
            if item == self {
                (self.parent!.parent as! projectDetail).expandedSectionDetails.remove(at: i)
                break
            }
            i += 1
        }
    }
    
}
