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
        //T.textColor = .white
        T.focusRingType = .none
      
       //let double = NSClickGestureRecognizer.init(target: self, action: #selector(handleDoubleClick))
        
        let triple  = NSClickGestureRecognizer.init(target: self, action: #selector(self.handleTriple))
        triple.numberOfClicksRequired = 3
        triple.isEnabled = true
        triple.delaysSecondaryMouseButtonEvents = false
        self.view.addGestureRecognizer(triple)
        
        
        let double = NSClickGestureRecognizer.init(target: self, action: #selector(self.handleDouble))
        double.numberOfClicksRequired = 2
        double.isEnabled = true
        self.view.addGestureRecognizer(double)
        self.T.refusesFirstResponder = true

        
        
        //let single = NSClickGestureRecognizer.init(target: self, action: #selector(handleSingle))
        //single.numberOfClicksRequired = 1
        //single.isEnabled = true
       // self.view.addGestureRecognizer(single)
    }
    
    
    @objc func handleTriple(){
        if !self.loadedChildren {
            self.T.backgroundColor = ThemeColor.white
            self.view.layer?.backgroundColor = ThemeColor.white.cgColor
            self.view.layer?.cornerRadius = 0
            VerticalSplit.instance!.handleAddSplitItem()
            self.loadedChildren = true
        }
        self.loadedDetail = false
        toggleDetail()
    }

    @objc func handleDouble(){
        toggleDetail()
    }
    
    func toggleDetail(){
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
        } else {
            (self.parent as! projectStack).handleCollapseDetail()
            self.view.layer?.cornerRadius = 10
            self.loadedDetail = false
        }
    }
    
    @IBOutlet weak var T: RoundedTextFieldCell!
    
    @IBAction func handleTitleEnter(_ sender: NSTextField) {
        sender.window?.makeFirstResponder(nil)
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

}


