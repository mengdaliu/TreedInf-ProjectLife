//
//  singleDone.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/11.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class singleDone: NSViewController {
    
    @IBOutlet weak var doneTitle: NSTextField!
    @IBOutlet var doneCommentField: NSTextView!
    @IBOutlet weak var scroll: customScrollView!
    
    var smallConstraint : NSLayoutConstraint!
    var largeConstraint : NSLayoutConstraint!
    var nilConstraint : NSLayoutConstraint!
    
    var project : Project!
    var percentage : Int16?
    var com : String?
    var loaded = false
    var d : Done!
    
   
    @IBOutlet weak var done: HoverButton!
    @IBOutlet weak var del: HoverButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        del.font = .labelFont(ofSize: 15)
        
        doneTitle.font = .labelFont(ofSize: 18)
        del.showsBorderOnlyWhileMouseInside = true
        
        del.setText(str: "delete", color: ThemeColor.red)
        
        doneCommentField.textColor = ThemeColor.blue
        self.smallConstraint = NSLayoutConstraint.init(item: scroll!, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        self.largeConstraint =  NSLayoutConstraint.init(item: scroll!, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        self.nilConstraint =  NSLayoutConstraint.init(item: scroll!, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        doneCommentField.isEditable = false
        scroll.drawsBackground = false
        scroll.layer?.backgroundColor = .init(gray: 1, alpha: 0)
        doneCommentField.font = .labelFont(ofSize: 18)
        doneCommentField.wantsLayer = true
        doneCommentField.drawsBackground = false
        doneCommentField.layer?.backgroundColor = .init(gray: 1, alpha: 0)
        
        NSLayoutConstraint.init(item: doneTitle!, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: del, attribute: .leading, multiplier: 1, constant: -1).isActive = true
    }
    
    
    
    
    @IBOutlet weak var clipView: NSClipView!
    
    
    func config(done : Done, project : Project, percent : Int16?, comment : String?) {
        self.d = done
        self.project = project
        self.percentage = percent
        self.com = comment
    }
    
    
    override func viewDidAppear() {
        scroll.superScrollFunc = (self.parent as! dailyDone).scroll.scrollWheel
        if !loaded {
            loaded = true
            if percentage != nil && percentage != 0 {
                doneTitle.stringValue = NSString.init(format: "• Finished %d%% of %@", percentage!, project.title ?? "") as String
            } else {
                doneTitle.stringValue = NSString.init(format: "• Worked on %@", project.title ?? "") as String
            }
            
            if self.com != nil && self.com != "" {
                self.doneCommentField.string = self.com!
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
        day.delete(done: self.d, from: (self.parent!.parent!.parent as! DayStack).day!)
        (self.parent as! dailyDone).stack?.removeView(self.view)
        self.removeFromParent()
    }
}

