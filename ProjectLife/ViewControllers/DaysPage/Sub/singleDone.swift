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
        
        
        let single = NSClickGestureRecognizer.init(target: self, action: #selector(handleSingle))
        single.numberOfClicksRequired = 1
        single.isEnabled = true
        self.view.addGestureRecognizer(single)
        single.delaysPrimaryMouseButtonEvents = false
        
        del.isEnabled = false
        del.isHidden = true
    }
    
    
    override func flagsChanged(with event: NSEvent) {
        if event.modifierFlags.contains(.command) {
            moveHelperGlobal.commandPressed = true
            NSEvent.addLocalMonitorForEvents(matching: NSEvent.EventTypeMask.keyUp, handler: { (event) -> NSEvent? in
                if event.modifierFlags.contains(.command) {
                    moveHelperGlobal.commandPressed = true
                    NSEvent.addLocalMonitorForEvents(matching: NSEvent.EventTypeMask.keyDown, handler: { (event) -> NSEvent? in
                        if  moveHelperGlobal.commandPressed {
                            if event.keyCode == 126 { //up
                                if daySelectGlobal.selected != nil {
                                    if daySelectGlobal.type == "singleDone" {
                                        (daySelectGlobal.selected!.parent as! dailyDone).handleMoveUp(item: daySelectGlobal.selected! as! singleDone)
                                    } else {
                                        (daySelectGlobal.selected!.parent as! dailyPlan).handleMoveUp(item: daySelectGlobal.selected! as! singlePlan)
                                    }
                                    
                                    return nil
                                }
                                
                            } else if event.keyCode == 125 { //down
                                if daySelectGlobal.selected != nil {
                                    if daySelectGlobal.type == "singleDone" {
                                         (daySelectGlobal.selected!.parent as! dailyDone).handleMoveDown(item: daySelectGlobal.selected! as! singleDone)
                                    } else {
                                         (daySelectGlobal.selected!.parent as! dailyPlan).handleMoveDown(item: daySelectGlobal.selected! as! singlePlan)
                                    }
                                   
                                    return nil
                                }
                                return nil
                            }
                        }
                        return nil
                    })
                } else {
                    moveHelperGlobal.commandPressed = false
                    return event
                }
                return event
            })
        }
    }
    
    
    @IBOutlet weak var clipView: NSClipView!
    
    
    @objc func handleSingle(){
        if daySelectGlobal.selected != nil {
            if daySelectGlobal.type == "singlePlan" {
                (daySelectGlobal.selected as! singlePlan).handleReturnNormal()
            } else {
                (daySelectGlobal.selected as! singleDone).handleReturnNormal()
            }
        }
        daySelectGlobal.selected = self
        daySelectGlobal.type = "singleDone"
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = .init(gray: 0.9, alpha: 0.9)
        self.view.window?.makeFirstResponder(self)
        del.isHidden = false
        del.isEnabled = true 
    }
    
    func handleReturnNormal() {
        daySelectGlobal.selected = nil
        self.view.layer?.backgroundColor = .init(gray: 1, alpha: 0)
        self.view.window?.makeFirstResponder(nil)
        del.isEnabled = false
        del.isHidden = true 
    }

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

