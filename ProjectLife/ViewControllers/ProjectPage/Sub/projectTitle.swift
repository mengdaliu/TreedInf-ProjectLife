//
//  projectTitle.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/31.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class projectTitle: NSViewController {
    
    var detail : projectDetail?
    var position : Int?
    var loadedDetail = false
    var loadedChildren = false
    
    @IBOutlet weak var textField: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        NSLayoutConstraint.init(item: self.T!, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
        //NSLayoutConstraint.init(item: self.T, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: -50).isActive = true
        
        let color = getRandomeColor()
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
    }
    
    override func viewDidAppear() {
        self.view.window?.makeFirstResponder(self.textField)
    }
    
    @IBOutlet weak var T: RoundedTextFieldCell!
    
    @IBAction func handleTitleEnter(_ sender: NSTextField) {
        sender.window?.firstResponder?.resignFirstResponder()
        (self.parent! as! projectStack).handleSetName(title : sender.stringValue)
    }
    
    
    func setStringValue(string : String) {
        T.stringValue = string
    }
    
    func setPosition(at Pos : Int) {
        self.position = Pos
    }
    
    func getRandomeColor() -> NSColor {
        var diff : Int
        let mini = 190
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
    
    override func scrollWheel(with event: NSEvent) {
        if event.deltaX <= -3 {
            if !self.loadedChildren {
                self.T.backgroundColor = ThemeColor.white
                self.view.layer?.backgroundColor = ThemeColor.white.cgColor
                VerticalSplit.instance!.handleLoadChildren(for: self.parent as! projectStack)
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
            }
        } else if event.deltaY <= -3 {
            if self.loadedDetail {
                (self.parent as! projectStack).handleCollapseDetail()
                self.view.layer?.cornerRadius = 10
                self.loadedDetail = false
            }
        }
    }
    
    func returnNormal() {
        self.view.layer?.cornerRadius = 10
        let color = getRandomeColor()
        self.view.layer?.backgroundColor = color.cgColor
        self.T.backgroundColor = color
    }
    
   
}


extension NSView {
    
    override open func rightMouseDown(with event: NSEvent) {
        super.rightMouseDown(with: event)
    }
    
    override open func scrollWheel(with event: NSEvent) {
        super.scrollWheel(with: event)
    }
    
}
