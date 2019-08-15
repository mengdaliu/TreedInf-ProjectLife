//
//  planForDay.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/15.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class planForDay: NSViewController {

    @IBOutlet weak var percentage: NSTextField!
    @IBOutlet var comment: CustomTextView!
    @IBOutlet weak var dateMenu: NSMenu!
    var today : Date!
    var tom : Date!
    var yes : Date!
    var dayBeforeYes : Date!
    var dayAfterTom : Date!
    var Selected : Date?
    
    @IBOutlet weak var customDatePicker: NSDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let attributes : [NSAttributedString.Key : Any] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : NSColor.gray]
        comment.placeholderAttributedString =  NSAttributedString(string: "optional comment on plan", attributes: attributes)
        
    
        NSLayoutConstraint.init(item: self.view, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 100).isActive = true
        
        
        let today = Date.init()
        self.today = today
        let todayHelper = dateUtils.init(date: today, relativeIndicator: 0)
        let todayString = todayHelper.forProjectSet()
        dateMenu.addItem(withTitle: todayString, action: #selector(self.handleSelectToday), keyEquivalent: "tab")
        
        
        let tommorrow = todayHelper.getDay(addBy: 1)
        self.tom = tommorrow
        let tommorrowHelper = dateUtils.init(date: tommorrow, relativeIndicator: 1)
        let tommorrowString = tommorrowHelper.forProjectSet()
        dateMenu.addItem(withTitle: todayString, action: #selector(self.handleSelectTom), keyEquivalent: "tab")
        
        let dayAfterTom = todayHelper.getDay(addBy: 2)
        self.dayAfterTom = dayAfterTom
        let dayAfterTomHelper = dateUtils.init(date: dayAfterTom, relativeIndicator: 2)
        let dayAfterTomString = dayAfterTomHelper.forProjectSet()
        dateMenu.addItem(withTitle: todayString, action: #selector(self.handleSelectDayAfterTom), keyEquivalent: "tab")
        
        let yesterday = todayHelper.getDay(addBy: -1)
        self.yes = yesterday
        let yesterdayHelper = dateUtils.init(date: yesterday, relativeIndicator: -1)
        let yesterdayString = yesterdayHelper.forProjectSet()
        dateMenu.addItem(withTitle: todayString, action: #selector(self.handleSelectYes), keyEquivalent: "tab")
        
        let dayBeforeYes = todayHelper.getDay(addBy: -2)
        self.dayBeforeYes = dayBeforeYes
        let dayBeforeYesHelper = dateUtils.init(date: dayBeforeYes, relativeIndicator: 2)
        let dayBeforeYesString = dayBeforeYesHelper.forProjectSet()
        dateMenu.addItem(withTitle: todayString, action: #selector(self.handleSelectDayBeforeYes), keyEquivalent: "tab")
        
        dateMenu.addItem(withTitle: "custom", action: #selector(self.handleCustom)
            , keyEquivalent: "tab")
        
        customDatePicker.isEnabled = false
        customDatePicker.isHidden = true
        customDatePicker.dateValue = today
    }
    
    @objc func handleSelectToday() {
        self.Selected = self.today
        customDatePicker.isEnabled = false
        customDatePicker.isHidden = true
    }
    
    @objc func handleSelectTom() {
        self.Selected = self.tom
        customDatePicker.isEnabled = false
        customDatePicker.isHidden = true
    }
    
    @objc func handleSelectYes(){
        self.Selected = self.yes
        customDatePicker.isEnabled = false
        customDatePicker.isHidden = true
    }
    
    @objc func handleSelectDayAfterTom() {
        self.Selected = self.dayAfterTom
        customDatePicker.isEnabled = false
        customDatePicker.isHidden = true
    }
    
    @objc func handleSelectDayBeforeYes(){
        self.Selected = self.dayBeforeYes
        customDatePicker.isEnabled = false
        customDatePicker.isHidden = true
    }
    
    @objc func handleCustom(){
        customDatePicker.isEnabled = true
        customDatePicker.isHidden = false
    }
    
    @IBAction func sendCustomValue(_ sender: NSDatePicker) {
        self.Selected = sender.dateValue
    }
}

class CustomTextView: NSTextView {
    var placeholderAttributedString: NSAttributedString?
}
