//
//  LogIn.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/16.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class SignIn: NSViewController {
    @IBOutlet weak var line1: NSTextField!
    
    @IBOutlet weak var line2: NSTextField!
    @IBOutlet weak var buttonOutlet: HoverButton!
    static var instance : SignIn?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        line1.font = .labelFont(ofSize: CGFloat(60))
        line2.font = .labelFont(ofSize: CGFloat(60))
        buttonOutlet.font = .labelFont(ofSize: CGFloat(60))
        let loadedData = UserDefaults.standard.data(forKey: "Theme Color")
        var loadedColor : NSColor?
        do {
            try loadedColor =  NSKeyedUnarchiver.unarchivedObject(ofClasses : [NSColor.self], from: loadedData!) as? NSColor
            if loadedColor != ThemeColor.white {
                buttonOutlet.setText(str: "Project Life!", color: loadedColor!)
            } else {
                buttonOutlet.setText(str: "Project Life!", color : ThemeColor.black)
            }
        } catch {}
        //buttonOutlet.frame = .init(origin: buttonOutlet.frame.origin, size: .init(width: CGFloat(120), height: CGFloat(35)))
        buttonOutlet.wantsLayer = true
        buttonOutlet.layer?.cornerRadius = 20
        //buttonOutlet.layer?.masksToBounds = true
        buttonOutlet.showsBorderOnlyWhileMouseInside = true
        SignIn.instance = self
    }
    
    @IBAction func buttonPush(_ sender: HoverButton) {
        NSAnimationContext.current.duration = 1
        let diff = line1.frame.origin.y - line2.frame.origin.y
        let line1EndOrigin = NSPoint.init(x: line1.frame.origin.x, y: line1.frame.origin.y + 250)
        let line2EndOrigin = NSPoint.init(x: line2.frame.origin.x,y: line2.frame.origin.y + 250)
        let buttonEndOrigin = NSPoint.init(x: sender.frame.origin.x, y: sender.frame.origin.y + 250)
        line1.animator().setFrameOrigin(line1EndOrigin)
        line2.animator().setFrameOrigin(line2EndOrigin)
        sender.animator().setFrameOrigin(buttonEndOrigin)
        //line1.animator().translatesAutoresizingMaskIntoConstraints = true
        let Constraint1 = NSLayoutConstraint.init(item: line1, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: -250)
        self.view.addConstraint(Constraint1)
        //self.view.addConstraint(Constraint2)
        line2.animator().setFrameOrigin(line2EndOrigin)
        let cons = -250 + diff
        let Constraint2 = NSLayoutConstraint.init(item: line2, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: cons)
        self.view.addConstraint(Constraint2)
        let ConstraintB = NSLayoutConstraint.init(item: sender, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: cons)
        self.view.addConstraint(ConstraintB)
        //sender.isEnabled = false
    }

    
    
    func changeButtonColor(color : NSColor) {
        if color != ThemeColor.white {
            buttonOutlet.setText(str: "Project Life!", color: color)
        } else {
            buttonOutlet.setText(str: "Project Life!", color : ThemeColor.black)
        }
    }
}
