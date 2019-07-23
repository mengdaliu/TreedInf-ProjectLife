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
    var buttonPushed : Bool = false
    static var instance : SignIn?

    
    @IBOutlet weak var facebookButton: NSButton!
   

   
    @IBOutlet weak var googleButton: NSButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        line1.font = .labelFont(ofSize: CGFloat(50))
        line2.font = .labelFont(ofSize: CGFloat(50))
        buttonOutlet.font = .labelFont(ofSize: CGFloat(50))
        let loadedColor = ColorGetter.getCurrentThemeColor()
        if loadedColor != ThemeColor.white {
            buttonOutlet.setText(str: "Project Life!", color: loadedColor)
        } else {
            buttonOutlet.setText(str: "Project Life!", color : ThemeColor.black)
        }
        //buttonOutlet.frame = .init(origin: buttonOutlet.frame.origin, size: .init(width: CGFloat(120), height: CGFloat(35)))
        buttonOutlet.wantsLayer = true
        buttonOutlet.layer?.cornerRadius = 20
        //buttonOutlet.layer?.masksToBounds = true
        buttonOutlet.showsBorderOnlyWhileMouseInside = true
       
            // Do whatever you want with the image
        
        SignIn.instance = self
    }
    
    @IBAction func logInFromFacebook(_ sender: Any) {
        HTTPCookieStorage.shared.removeCookies(since: .distantPast)
        let facebookViewController = signInWeb.init(nibName: "signInWeb", bundle: nil)
        self.addChild(facebookViewController)
        self.presentAsSheet(facebookViewController)
    }
    
    @IBAction func logInFromGoogle(_ sender: Any) {
    }
    
    
    func handleCollapse() {
        self.dismiss(self.children[0])
        let web = self.children[0] as! signInWeb
        self.removeChild(at: 0)
        
        HTTPCookieStorage.shared.removeCookies(since: .distantPast)
        if web.gotToken {
            SignInHandler.SignInFromFacebook(token : web.token)
        }
       
    }
    
    @IBAction func buttonPush(_ sender: HoverButton) {
        if !buttonPushed {
            NSAnimationContext.current.duration = 1.5
            let diff = line1.frame.origin.y - line2.frame.origin.y
            let line1EndOrigin = NSPoint.init(x: line1.frame.origin.x, y: line1.frame.origin.y + 200)
            let line2EndOrigin = NSPoint.init(x: line2.frame.origin.x,y: line2.frame.origin.y + 200)
            let buttonEndOrigin = NSPoint.init(x: sender.frame.origin.x, y: sender.frame.origin.y + 200)
            line1.animator().setFrameOrigin(line1EndOrigin)
            line2.animator().setFrameOrigin(line2EndOrigin)
            sender.animator().setFrameOrigin(buttonEndOrigin)
            //line1.animator().translatesAutoresizingMaskIntoConstraints = true
            let Constraint1 = NSLayoutConstraint.init(item: line1, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: -200)
            self.view.addConstraint(Constraint1)
            //self.view.addConstraint(Constraint2)
            line2.animator().setFrameOrigin(line2EndOrigin)
            let cons = -200 + diff
            let Constraint2 = NSLayoutConstraint.init(item: line2, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: cons)
            self.view.addConstraint(Constraint2)
            let ConstraintB = NSLayoutConstraint.init(item: sender, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: cons)
            self.view.addConstraint(ConstraintB)
            //sender.isEnabled = false
            let transition = CATransition.init()
            transition.duration = 3
            transition.type = .reveal
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            
            
            
            let fbImage = NSImage.init(contentsOfFile: Bundle.main.path(forResource: "facebook", ofType: "png")!)
            facebookButton.wantsLayer = true
            facebookButton.layer?.add(transition, forKey: nil)
            facebookButton.image = fbImage
            //facebookButton.isBordered = true
            facebookButton.setFrameSize(.init(width: 389.997, height: 148.203))
            facebookButton.imageScaling = .scaleProportionallyDown
            facebookButton.image?.alignmentRect = facebookButton.frame
            
            let googleImage = NSImage.init(contentsOfFile: Bundle.main.path(forResource: "google", ofType: "png")!)
            googleButton.wantsLayer = true
            googleButton.layer?.add(transition, forKey: nil)
            googleButton.image = googleImage
            googleButton.setFrameSize(.init(width: 465.4832, height: 176.1892))
            googleButton.imageScaling = .scaleProportionallyDown
            googleButton.image?.alignmentRect = googleButton.frame
            
            DispatchQueue.main.async {
                NSAnimationContext.current.duration = 1
                let fbEndOrigin = NSPoint.init(x: self.facebookButton.frame.origin.x, y: self.facebookButton.frame.origin.y - 250)
                self.facebookButton.animator().setFrameOrigin(fbEndOrigin)
                let ConstraintFb = NSLayoutConstraint.init(item: self.facebookButton, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 125)
                
                
                
                let ggEndOrigin = NSPoint.init(x:  self.googleButton.frame.origin.x, y: self.googleButton.frame.origin.y - 250)
                self.googleButton.animator().setFrameOrigin(ggEndOrigin)
                let ConstraintGg = NSLayoutConstraint.init(item: self.googleButton, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 250)
                
                
                self.view.addConstraint(ConstraintFb)
                self.view.addConstraint(ConstraintGg)
                self.buttonPushed = true
            }
        }
    }

    
    
    func changeButtonColor(color : NSColor) {
        if color != ThemeColor.white {
            buttonOutlet.setText(str: "Project Life!", color: color)
        } else {
            buttonOutlet.setText(str: "Project Life!", color : ThemeColor.black)
        }
    }
}
