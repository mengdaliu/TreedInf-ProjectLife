//
//  projectTitle.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/31.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class projectTitle: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        NSLayoutConstraint.init(item: self.T, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
        //NSLayoutConstraint.init(item: self.T, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: -50).isActive = true
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
        print(R, G, B)
        let r = CGFloat(R)/CGFloat(256)
        let g = CGFloat(G)/CGFloat(256)
        let b = CGFloat(B)/CGFloat(256)
        let RGB = String(R) +  ", " + String(G) + ", " + String(B)
        print(r, g, b)
        let color = NSColor.init(red: r, green: g, blue: b, alpha: 1)
        self.view.layer?.backgroundColor = color.cgColor
        self.view.layer?.masksToBounds = true
        self.view.layer?.cornerRadius = 10
        T.font = .labelFont(ofSize: 20)
        T.alignment = .center
        T.drawsBackground = true
        T.backgroundColor = color
        T.textColor = .black
        T.stringValue = RGB
        
    }
    
    @IBOutlet weak var T: RoundedTextFieldCell!
    @IBAction func handleTitleEnter(_ sender: NSTextField) {
        
    }
}
