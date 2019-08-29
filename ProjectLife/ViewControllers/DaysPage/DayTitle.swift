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
        DateLabel.font = .labelFont(ofSize: 19)
        DateLabel.textColor = ColorGetter.getCurrentThemeColor()
        if DateLabel.textColor == ThemeColor.white {
            DateLabel.textColor = ThemeColor.black
        }
        NSLayoutConstraint.init(item: self.view, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 30).isActive = true
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = .init(gray: 0.9, alpha: 1)
        
        let double = NSClickGestureRecognizer.init(target: self, action: #selector(handleToggleDetail))
        double.numberOfClicksRequired = 2
        double.isEnabled = true
        self.view.addGestureRecognizer(double)
    }
    
    
    
    func setDate(date : Date) {
        let today = Date.init()
        let todayUtil = dateUtils.init(date: today, relativeIndicator: 0)
        let yesterday = todayUtil.getDay(addBy: -1)
        let tommorrow = todayUtil.getDay(addBy: 1)
        if dateUtils.equal(dayA: date, dayB: today) {
            self.DateLabel.stringValue = todayUtil.forDayPage()
        } else if dateUtils.equal(dayA: date, dayB: yesterday) {
            self.DateLabel.stringValue = dateUtils.init(date: yesterday, relativeIndicator: -1).forDayPage()
        } else if dateUtils.equal(dayA: date, dayB: tommorrow) {
            self.DateLabel.stringValue = dateUtils.init(date: tommorrow, relativeIndicator: 1).forDayPage()
        } else {
            self.DateLabel.stringValue = dateUtils.init(date: date, relativeIndicator: 10).forDayPage()
        }
        
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
            (self.parent as! DayStack).addChild(detail)
            (self.parent as! DayStack).stack.setCustomSpacing(0, after: self.view)
            self.detail = detail
        } else {
            (self.parent as! DayStack).stack.removeView(self.detail!.view)
            (self.parent as! DayStack).removeChild(at: 1)
            self.detail?.removeFromParent()
            self.detail = nil
        }
        daySelectGlobal.selected = nil 
    }
}
