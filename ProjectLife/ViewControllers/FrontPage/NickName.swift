//
//  NickName.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/23.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class NickName: NSViewController {
    
    static var instance : NickName?
    
    var loaded : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        greetingLine.font = .labelFont(ofSize: 50)
        nameField.font = .labelFont(ofSize: 50)
        nameField.isBezeled = false
        nameField.focusRingType = .none
       
        
        let lineView = lineDrawer.init()
        
        let color = ColorGetter.getCurrentThemeColor()
        greetingLine.textColor = color
        nameField.textColor = color
        
        lineView.setFrameSize(nameField.frame.size)
        self.view.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.init(item: lineView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: lineView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.3, constant: -15).isActive = true
        NSLayoutConstraint.init(item: lineView, attribute: .width, relatedBy: .equal, toItem: self.nameField, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: lineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100).isActive = true
        
        
        
        
        NickName.instance = self
    }
    
    override func viewDidAppear() {
        if !loaded {
            loaded = true
            
            DispatchQueue.main.async {
                
                let endOrigin = NSPoint.init(x: 41, y: 146)
                NSAnimationContext.current.duration = 0.5
                self.greetingLine.animator().setFrameOrigin(endOrigin)
                NSLayoutConstraint.init(item: self.greetingLine, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 0.8, constant: 0).isActive = true
                
            }
        }
    }   


    @IBAction func enteredName(_ sender: NSTextField) {
        userInfo.setNickName(nickName: sender.stringValue)
        if sender.stringValue.count > 1 {
            let parent = self.parent as! FrontPagePhoto
            let enterView = Enter.init(nibName: "Enter", bundle: nil)
            parent.addChild(enterView)
            parent.GreetingAndButton.contentView = enterView.view
            if ViewController.instance != nil {
                ViewController.instance?.ActivateAll()
            }
        }
        
    }
    
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var greetingLine: NSTextField!
    
    func changeQuestionColor(color : NSColor) {
        greetingLine.textColor = color
        nameField.textColor = color
    }
    
    

}







