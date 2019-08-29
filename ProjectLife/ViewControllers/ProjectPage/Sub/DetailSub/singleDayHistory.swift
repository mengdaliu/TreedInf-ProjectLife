//
//  singleDayHistory.swift
//  ProjectLife
//
//  Created by 刘梦达 on 2019/8/23.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class singleDayHistory: NSViewController {

    @IBOutlet weak var dateLabel: NSTextField!
    var history : ProjectHistory!
    
    @IBOutlet weak var Stack: flippedView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
       
       
         //Stack.translatesAutoresizingMaskIntoConstraints = false
        // NSLayoutConstraint.init(item: self.view, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 900).isActive = true
        Stack.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        Stack.spacing = 1
        Stack.orientation = .vertical
        Stack.alignment = .centerX
        dateLabel.drawsBackground = true
        dateLabel.backgroundColor = NSColor.init(cgColor : CGColor.init(gray: 0.92, alpha: 0))!
        dateLabel.font = .labelFont(ofSize: 17)
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = CGColor.init(gray: 0.92, alpha: 0)
       
    }
    
    override func viewDidAppear() {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "MM/dd/yyyy"
        let dString = formatter.string(from: self.history.date!)
        self.dateLabel.stringValue = dString
        
        
        for act in Array(self.history.action ?? []) {
            let single = singleHistory.init(nibName: "singleHistory", bundle: nil)
            single.setAction(action: act as! Action)
            single.view.translatesAutoresizingMaskIntoConstraints = false
            self.Stack.addArrangedSubview(single.view)
            self.addChild(single)
        }
        self.Stack.addArrangedSubview(trivialLine.init(nibName: "trivialLine", bundle: nil).view)
    }
    
    func setHistory(history : ProjectHistory) {
        self.history = history
    }
}
