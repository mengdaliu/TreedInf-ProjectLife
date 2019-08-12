//
//  DayStack.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/9.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class DayTitle: NSViewController {

    @IBOutlet weak var DateLabel: NSTextField!
    @IBOutlet weak var line: NSBox!
    @IBOutlet weak var DisclosureTriangle: NSButton!
    var detail : DayDetail?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        DateLabel.font = .labelFont(ofSize: 18)
        DateLabel.textColor = ColorGetter.getCurrentThemeColor()
        NSLayoutConstraint.init(item: self.view, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 30).isActive = true
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = .init(gray: 0.9, alpha: 1)
        
        let double = NSClickGestureRecognizer.init(target: self, action: #selector(handleToggleDetail))
        double.numberOfClicksRequired = 2
        double.isEnabled = true
        self.view.addGestureRecognizer(double)
    }
    
    
    
    func setDate(date : Date) {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "MM/dd/yyyy"
        let dString = formatter.string(from: date)
        self.DateLabel.stringValue = dString
    }
    
    @objc func handleToggleDetail(){
        if self.detail == nil  {
            let detail = DayDetail.init(nibName: "DayDetail", bundle: nil)
            (self.parent as! DayStack).stack.addArrangedSubview(detail.view)
            (self.parent as! DayStack).addChild(detail)
            if (self.parent as! DayStack).day!.plans != nil {
                
            }
            if (self.parent as! DayStack).day!.dones != nil {
                
            }
            (self.parent as! DayStack).stack.setCustomSpacing(0, after: self.view)
            self.detail = detail
        } else {
            (self.parent as! DayStack).stack.removeView(self.detail!.view)
            (self.parent as! DayStack).removeChild(at: 1)
            self.detail = nil
        }
    }
}
