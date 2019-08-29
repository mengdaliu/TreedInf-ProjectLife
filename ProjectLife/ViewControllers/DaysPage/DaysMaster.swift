//
//  DaysMaster.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/9.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class DaysMaster: NSViewController {

    @IBOutlet weak var scroll: NSScrollView!
    static var instance : DaysMaster?
    var stack : flippedView?
    var last : Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let stack = flippedView.init(frame: scroll.documentView!.frame)
        self.stack = stack
        scroll.documentView = stack
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.setClippingResistancePriority(.defaultLow, for: .vertical)
        scroll.drawsBackground = false
        NSLayoutConstraint.init(item: stack, attribute: .leading, relatedBy: .equal, toItem: scroll, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: stack, attribute: .trailing, relatedBy: .equal, toItem: scroll, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: stack, attribute: .top, relatedBy: .equal, toItem: scroll, attribute: .top, multiplier: 1, constant: 20).isActive = true
        
        stack.orientation = .vertical
        stack.alignment = .centerX
        stack.distribution = .gravityAreas
        stack.setHuggingPriority(.defaultLow, for: .vertical)
        stack.spacing = 0
        DaysMaster.instance = self
        
        let today = Date.init()
        let yesterday = dateUtils.init(date: today, relativeIndicator: 0).getDay(addBy: -1)
        let tommorrow = dateUtils.init(date: today, relativeIndicator: 0).getDay(addBy: 1)
        let days = day.loadDays()
        for day in days ?? [] {
            let d = DayStack.init(nibName: "DayStack", bundle: nil)
            self.stack!.addArrangedSubview(d.view)
            self.addChild(d)
            NSLayoutConstraint.init(item: d.view, attribute: .width, relatedBy: .equal, toItem: self.stack, attribute: .width, multiplier: 1, constant: 0).isActive = true
            d.setDay(day: day)
            if dateUtils.equal(dayA: day.date!, dayB: today) || dateUtils.equal(dayA : day.date!, dayB : tommorrow) || dateUtils.equal(dayA : day.date! , dayB : yesterday) {
                d.dTitle?.handleToggleDetail()
            }
        }
    }
    
    func loadDays() {
        var last = self.last
        let today = Date.init()
        let sevenFromNow = Calendar.current.date(byAdding: .day, value: 7, to: today)
        if last == nil {
            let t = day.Add(day: today)
            last = today
            let d = DayStack.init(nibName: "DayStack", bundle: nil)
            self.stack!.addArrangedSubview(d.view)
            self.addChild(d)
            d.setDay(day: t)
        }
        func matched(DayA : Date, DayB: Date) -> Bool {
            let ADate = Calendar.current.component(.day, from: DayA)
            let BDate = Calendar.current.component(.day, from: DayB)
            let AMonth = Calendar.current.component(.month, from: DayA)
            let BMonth = Calendar.current.component(.month, from: DayB)
            return ADate == BDate && AMonth == BMonth
        }
        var ok = matched(DayA: last!, DayB: sevenFromNow!)
        while !ok {
            let next = Calendar.current.date(byAdding: .day, value: 1, to: last!)
            let new = day.Add(day: next!)
            let d = DayStack.init(nibName: "DayStack", bundle: nil)
            self.stack!.addArrangedSubview(d.view)
            NSLayoutConstraint.init(item: d.view, attribute: .width, relatedBy: .equal, toItem: self.stack, attribute: .width, multiplier: 1, constant: 0).isActive = true
            self.addChild(d)
            last = next
            d.setDay(day: new)
            ok = matched(DayA: next!, DayB: sevenFromNow!)
        }
        self.last = last
    }
    
    
    func loadDaysHelper() -> Date? {
        let days = day.loadDays()
        var last : Day?
        if days != nil {
            for day in days! {
                let d = DayStack.init(nibName: "DayStack", bundle: nil)
                self.stack!.addArrangedSubview(d.view)
                self.addChild(d)
                NSLayoutConstraint.init(item: d.view, attribute: .width, relatedBy: .equal, toItem: self.stack, attribute: .width, multiplier: 1, constant: 0).isActive = true 
                d.setDay(day: day)
                last = day
            }
            return last?.date
        }
        return nil
    }
    
    override func mouseDown(with event: NSEvent) {
        if daySelectGlobal.type == "singlePlan" {
            (daySelectGlobal.selected as? singlePlan)?.handleReturnNormal()
        } else if daySelectGlobal.type == "singleDone" {
            (daySelectGlobal.selected as? singleDone)?.handleReturnNormal()
        }
        self.view.window?.makeFirstResponder(nil)
    }
    
    func handleChangeColor(color : NSColor) {
        for item in self.children {
            (item as? DayStack)?.dTitle?.DateLabel.textColor = color
        }
    }
}
