//
//  singleHistory.swift
//  ProjectLife
//
//  Created by 刘梦达 on 2019/8/23.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class singleHistory: NSViewController {

    @IBOutlet weak var oneLineDescription: NSTextField!
    @IBOutlet var optionalComment: NSTextView!
    @IBOutlet weak var scroll: NSScrollView!
    var smallConstraint : NSLayoutConstraint!
    var largeConstraint : NSLayoutConstraint!
    var nilConstraint : NSLayoutConstraint!
    
    var act : Action!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.smallConstraint = NSLayoutConstraint.init(item: scroll!, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        self.largeConstraint =  NSLayoutConstraint.init(item: scroll!, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        self.nilConstraint =  NSLayoutConstraint.init(item: scroll!, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 0)
    }
    
    func setAction(action : Action) {
        self.act = action
    }
    
    override func viewDidAppear() {
        if act.type == "Plan" {
            oneLineDescription.font = .labelFont(ofSize: 18)
            oneLineDescription.textColor = ThemeColor.red
            if act.plan!.percentage != 0 {
                oneLineDescription.stringValue = NSString.init(format: "• Planned to Finish %d%%", act.plan!.percentage) as String
            } else {
                oneLineDescription.stringValue = NSString.init(format: "• Planned to Work") as String
            }
            
            if self.act.plan!.comment != nil && self.act.plan!.comment != "" {
                self.optionalComment.font = .labelFont(ofSize: 18)
                self.optionalComment.string = self.act.plan!.comment!
                self.smallConstraint.isActive = true
                self.optionalComment.textColor = ThemeColor.blue
            } else {
                self.nilConstraint.isActive = true
            }
        } else if act.type == "Done" {
            oneLineDescription.font = .labelFont(ofSize: 18)
            oneLineDescription.textColor = ThemeColor.green
            if act.done!.percentage != 0 {
                oneLineDescription.stringValue = NSString.init(format: "• Finished %d%%", act.plan!.percentage) as String
            } else {
                oneLineDescription.stringValue = NSString.init(format: "• Worked") as String
                
            }
            
            if self.act.done!.comment != nil && self.act.done!.comment != "" {
                self.optionalComment.font = .labelFont(ofSize: 18)
                self.optionalComment.string = self.act.done!.comment!
                self.smallConstraint.isActive = true
                self.optionalComment.textColor = ThemeColor.blue
            } else {
                self.nilConstraint.isActive = true
            }
        } else if act.type == "Create" {
            let attributes : [NSAttributedString.Key : Any] = [
                NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : ThemeColor.black,
                NSAttributedString.Key(rawValue : NSAttributedString.Key.font.rawValue) : NSFont.labelFont(ofSize: 18)
            ]
            oneLineDescription.attributedStringValue = NSAttributedString.init(string: "• Created", attributes: attributes)
        } else if act.type == "Archive" {
            let attributes : [NSAttributedString.Key : Any] = [
                NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : ThemeColor.brown,
                NSAttributedString.Key(rawValue : NSAttributedString.Key.font.rawValue) : NSFont.labelFont(ofSize: 18)
            ]
            oneLineDescription.attributedStringValue = NSAttributedString.init(string: "• Archived", attributes: attributes)
        } else if act.type == "Reactivate" {
            let attributes : [NSAttributedString.Key : Any] = [
                NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : ThemeColor.peru,
                NSAttributedString.Key(rawValue : NSAttributedString.Key.font.rawValue) : NSFont.labelFont(ofSize: 18)
            ]
            oneLineDescription.attributedStringValue = NSAttributedString.init(string: "• Reactivated", attributes: attributes)
        }
    }
}
