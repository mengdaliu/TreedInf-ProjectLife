//
//  projectTitle.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/31.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class projectTitle: NSViewController, NSTextFieldDelegate {
    
    var detail : projectDetail?
    var position : Int?
    var loadedDetail = false
    var loadedChildren = false
    var shiftPressed = false
    var commandPressed = false
    var stopScroll = false
    
    @IBOutlet weak var textField: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        NSLayoutConstraint.init(item: self.T!, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
        //NSLayoutConstraint.init(item: self.T, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: -50).isActive = true
        
        let color = getRandomColorTwo()
        self.view.layer?.backgroundColor = color.cgColor
        self.view.layer?.masksToBounds = true
        self.view.layer?.cornerRadius = 10
        
        T.font = .labelFont(ofSize: 20)
        T.alignment = .center
        T.drawsBackground = true
        T.backgroundColor = color
        T.textColor = .black
        T.focusRingType = .none

        
        self.view.wantsRestingTouches = true
        self.view.allowedTouchTypes = .indirect
        
        self.textField.isAutomaticTextCompletionEnabled = true
        self.textField.delegate = self
    }
    
    override func viewDidAppear() {
        self.view.window?.makeFirstResponder(self.textField)
    }
    
    @IBOutlet weak var T: RoundedTextFieldCell!
    
    @IBAction func handleTitleEnter(_ sender: NSTextField) {
        sender.window?.makeFirstResponder(nil)
        (self.parent! as! projectStack).handleSetName(title : sender.stringValue)
    }
    
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if (commandSelector == #selector(NSResponder.insertNewline(_:))) {
            // Do something against ENTER key
            if !self.shiftPressed {
                if ((self.parent as! projectStack).p.subProjects?.count == 0 && self.T!.stringValue == "") {
                    (self.parent!.parent as! VerticalStack).handleDelete(item: self.parent as! projectStack)
                } else {
                    (self.parent?.parent as! VerticalStack).addProjectItem()
                }
            } else {
                var detailVC : projectDetail
                if self.detail != nil {
                    detailVC = self.detail!
                } else {
                    detailVC = projectDetail.init(nibName: "projectDetail", bundle: nil)
                    self.detail = detailVC
                }
                (self.parent as! projectStack).handleDropDownDetail(VC: detailVC)
                detailVC.handleExpandOverview()
            }
            return true
        }  else if (commandSelector == #selector(NSResponder.insertTab(_:))) {
            
            if !self.loadedChildren {
                self.T.backgroundColor = ThemeColor.white
                self.view.layer?.backgroundColor = ThemeColor.white.cgColor
                self.T.font = .labelFont(ofSize: 21)
                let sub = VerticalSplit.instance!.handleLoadChildren(for: self.parent as! projectStack)
                self.loadedChildren = true
                sub.addProjectItem()
            } else {
                let sub = (self.parent as! projectStack).childrenVC!
                (sub as! VerticalStack).addProjectItem()
            }
            return true
        }
    
        // return true if the action was handled; otherwise false
        return false
    }
    
    
    func setStringValue(string : String) {
        T.stringValue = string
    }
    
    func setPosition(at Pos : Int) {
        self.position = Pos
    }
    
    func getRandomeColor() -> NSColor {
        var diff : Int
        let mini = 200
        let maxi = 230
        self.view.wantsLayer = true
        let R = Int.random(in: mini...maxi)
        if R > 220 {diff = 5}
        else if R > 205 {diff = 10}
        else {diff = 15}
        var min_G = R - diff
        if min_G < mini {min_G = mini}
        var max_G = R + diff
        if max_G > maxi {max_G = maxi}
        let G = Int.random(in: min_G...max_G)
        var max_B = min(R, G) + diff
        if max_B > maxi {max_B = maxi}
        var min_B = max(R, G) - diff
        if min_B < mini {min_B = mini}
        let B = Int.random(in: min_B...max_B)
        let r = CGFloat(R)/CGFloat(256)
        let g = CGFloat(G)/CGFloat(256)
        let b = CGFloat(B)/CGFloat(256)
        let color = NSColor.init(red: r, green: g, blue: b, alpha: 1)
        return color
    }
    
    func getRandomColorTwo() -> NSColor {
        let mini = 211
        let maxi = 216
        self.view.wantsLayer = true
        let R = Int.random(in: mini...maxi)
        let G = Int.random(in: mini...maxi) - 1
        let B = 634 - R - G
        let r = CGFloat(R)/CGFloat(256)
        let g = CGFloat(G)/CGFloat(256)
        let b = CGFloat(B)/CGFloat(256)
        let color = NSColor.init(red: r, green: g, blue: b, alpha: 1)
        return color
    }
    
    override func scrollWheel(with event: NSEvent) {
        if event.deltaX <= -3 {
            if !self.loadedChildren {
                self.T.backgroundColor = ThemeColor.white
                self.view.layer?.backgroundColor = ThemeColor.white.cgColor
                VerticalSplit.instance!.handleLoadChildren(for: self.parent as! projectStack)
                self.T.font = .labelFont(ofSize: 21)
                self.loadedChildren = true
            }
            self.view.window?.makeFirstResponder(nil)
        } else if event.deltaY >= 3 {
            var detailVC : projectDetail
            if self.detail != nil {
                detailVC = self.detail!
            } else {
                detailVC = projectDetail.init(nibName: "projectDetail", bundle: nil)
                self.detail = detailVC
            }
            if !self.loadedDetail {
                (self.parent as! projectStack).handleDropDownDetail(VC: detailVC)
                
                self.view.layer?.cornerRadius = 0
                self.loadedDetail = true
                self.stopScroll = true
                let temp = self
                let timer = customTimer.init(seconds: 10, useconds: nil, completionHandler: {
                    temp.stopScroll = false
                })
                DispatchQueue.global(qos: .background).async {
                    timer.start()
                }
            } else if !self.stopScroll {
                super.scrollWheel(with: event)
            }
        } else if event.deltaY <= -3 {
            if self.loadedDetail {
                (self.parent as! projectStack).handleCollapseDetail()
                self.view.layer?.cornerRadius = 10
                self.loadedDetail = false
                let temp = self
                let timer = customTimer.init(seconds: 10, useconds: nil, completionHandler: {
                    temp.stopScroll = false
                })
                DispatchQueue.global(qos: .background).async {
                    timer.start()
                }
            } else if !self.stopScroll {
                super.scrollWheel(with: event)
            }
        }
    }
    
    func returnNormal() {
        self.view.layer?.cornerRadius = 10
        let color = getRandomColorTwo()
        self.view.layer?.backgroundColor = color.cgColor
        self.T.backgroundColor = color
        self.T.font = .labelFont(ofSize: 20)
    }
    
    
    override func flagsChanged(with event: NSEvent) {
        if event.modifierFlags.contains(.shift) {
            self.shiftPressed = true
        } else {
            self.shiftPressed = false
        }
        
        if event.modifierFlags.contains(.command) {
            self.commandPressed = true
        } else {
            self.commandPressed = false
        }
    }
    
    override func keyUp(with event: NSEvent) {
        super.keyUp(with: event)
        if event.keyCode == 126 {
            //up
        } else if event.keyCode == 123 {
            //left
        } else if event.keyCode == 124 {
            //down
        } else if event.keyCode == 125 {
            //right
        }
    }
}


extension NSView {
    override open var acceptsFirstResponder: Bool {
       return true
    }
    
    override open func becomeFirstResponder() -> Bool {
        return true
    }
    
    
    override open func rightMouseDown(with event: NSEvent) {
        super.rightMouseDown(with: event)
    }
    
    override open func scrollWheel(with event: NSEvent) {
        super.scrollWheel(with: event)
    }
    
    override open func keyUp(with event: NSEvent) {
        super.keyUp(with: event)
    }
    
    override open func flagsChanged(with event: NSEvent) {
        super.flagsChanged(with: event)
    }
}
