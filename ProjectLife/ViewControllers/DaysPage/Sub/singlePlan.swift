//
//  singlePlan.swift
//  ProjectLife
//
//  Created by 刘梦达 on 2019/8/18.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class singlePlan: NSViewController {

    @IBOutlet weak var edit: NSButton!
    @IBOutlet weak var planTitle: NSTextField!
    @IBOutlet var commentField: NSTextView!
    @IBOutlet weak var scroll: customScrollView!
    var smallConstraint : NSLayoutConstraint!
    var largeConstraint : NSLayoutConstraint!
    var nilConstraint : NSLayoutConstraint!
    
    var project : Project!
    var percentage : Int16?
    var com : String?
    var loaded = false
    var p : Plan!
    
    @IBOutlet weak var del: HoverButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        del.font = .labelFont(ofSize: 15)
        planTitle.font = .labelFont(ofSize: 18)
        del.showsBorderOnlyWhileMouseInside = true
        del.setText(str: "delete", color: ThemeColor.red)
        commentField.textColor = ThemeColor.blue
        self.smallConstraint = NSLayoutConstraint.init(item: scroll!, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        self.largeConstraint =  NSLayoutConstraint.init(item: scroll!, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        self.nilConstraint =  NSLayoutConstraint.init(item: scroll!, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        commentField.isEditable = false
        scroll.drawsBackground = false
        scroll.layer?.backgroundColor = .init(gray: 1, alpha: 0)
        commentField.font = .labelFont(ofSize: 18)
        commentField.wantsLayer = true
        commentField.drawsBackground = false 
        commentField.layer?.backgroundColor = .init(gray: 1, alpha: 0)
        
        NSLayoutConstraint.init(item: planTitle!, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: del, attribute: .leading, multiplier: 1, constant: -1).isActive = true
        
        
    }
    
    
   
    
    @IBOutlet weak var clipView: NSClipView!
    
    
    func config(plan : Plan, project : Project, percent : Int16?, comment : String?) {
        self.p = plan
        self.project = project
        self.percentage = percent
        self.com = comment
    }

    
    override func viewDidAppear() {
        scroll.superScrollFunc = (self.parent as! dailyPlan).scroll.scrollWheel
        if !loaded {
            loaded = true
            if percentage != nil && percentage != 0 {
                planTitle.stringValue = NSString.init(format: "• Finish %d%% of %@", percentage!, project.title ?? "") as String
            } else {
                planTitle.stringValue = NSString.init(format: "• Work on %@", project.title ?? "") as String
            }
            
            if self.com != nil && self.com != "" {
                self.commentField.string = self.com!
                self.smallConstraint.isActive = true
            } else {
                self.nilConstraint.isActive = true
            }
        }
    }
    
    override func rightMouseDown(with event: NSEvent) {
        if !self.nilConstraint.isActive {
            if self.smallConstraint.isActive {
                scroll.allowScroll = true
                self.smallConstraint.isActive = false
                self.largeConstraint.isActive = true
            } else {
                scroll.allowScroll = false
                self.largeConstraint.isActive = false
                self.smallConstraint.isActive = true
            }
        }
    }
    

    @IBAction func edit(_ sender: Any) {
    }
    
    @IBAction func done(_ sender: Any) {
    }
    
    @IBAction func delete(_ sender: Any) {
        day.delete(plan: self.p, from: (self.parent!.parent!.parent as! DayStack).day!)
        (self.parent as! dailyPlan).stack?.removeView(self.view)
        self.removeFromParent()
    }
    
    override func mouseEntered(with event: NSEvent) {
        del.isHidden = false
    }

    override func mouseExited(with event: NSEvent) {
        del.isHidden = true 
    }
}


class customScrollView  : NSScrollView {
    var allowScroll = false
    var superScrollFunc : ((NSEvent)->())!
    
    
    override func scrollWheel(with event: NSEvent) {
        if allowScroll {
            super.scrollWheel(with: event)
            
        } else {
            superScrollFunc(event)
        }
    }

}

extension NSView {
    override open func mouseEntered(with event: NSEvent) {
        print("true")
        super.mouseEntered(with: event)
    }
    
    override open func mouseExited(with event: NSEvent) {
        print("false")
        super.mouseExited(with: event)
    }
}
