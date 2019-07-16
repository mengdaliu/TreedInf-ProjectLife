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
    @IBOutlet weak var buttonOutlet: NSButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        line1.font = .labelFont(ofSize: CGFloat(60))
        line2.font = .labelFont(ofSize: CGFloat(60))
        buttonOutlet.font = .labelFont(ofSize: CGFloat(60))
        buttonOutlet.bezelStyle = .regularSquare
        buttonOutlet.bezelColor = ThemeColor.brown
        buttonOutlet.frame = .init(origin: buttonOutlet.frame.origin, size: .init(width: CGFloat(120), height: CGFloat(35)))
        buttonOutlet.wantsLayer = true
        buttonOutlet.layer?.backgroundColor = ThemeColor.Tblue.cgColor
        buttonOutlet.layer?.borderColor = ThemeColor.peru.cgColor
        buttonOutlet.layer?.masksToBounds = false
        buttonOutlet.layer?.cornerRadius = 20        //buttonOutlet.isTransparent = true
        //buttonOutlet.alphaValue = CGFloat(0)
       //buttonOutlet.bezelColor = ThemeColor.blue
        //buttonOutlet.isBordered = true
        buttonOutlet.showsBorderOnlyWhileMouseInside = true
        //buttonOutlet.alphaValue = CGFloat(0.5)
        //buttonOutlet.mouseEntered(with: <#T##NSEvent#>)
    }
    
    @IBAction func signInAction(_ sender: NSButton) {
    }
}
