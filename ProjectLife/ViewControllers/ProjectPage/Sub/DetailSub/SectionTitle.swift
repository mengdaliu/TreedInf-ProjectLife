//
//  Description.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/2.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class SectionTitle: NSViewController {

    @IBOutlet weak var DescriptionTitle: NSTextField!
    @IBOutlet weak var line: NSBox!
    @IBOutlet weak var ClosureTriangle: NSButton!
    var stack : flippedView!
    var detail : NSViewController?
    var expanded = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DescriptionTitle.font = .labelFont(ofSize: 17)
        line.boxType = .custom
        line.borderColor =  ColorGetter.getCurrentThemeColor()
        line.translatesAutoresizingMaskIntoConstraints = false
        DescriptionTitle.translatesAutoresizingMaskIntoConstraints = false
        line.setFrameSize(.init(width: 100, height: 1))
        NSLayoutConstraint.init(item: line!, attribute: .width, relatedBy: .equal, toItem: DescriptionTitle, attribute: .width, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint.init(item: line!, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 1).isActive = true
        NSLayoutConstraint.init(item: self.view, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 40).isActive = true
    }
    
    
    @IBAction func clickDisclosure(_ sender: NSButton) {
        if !expanded {
            switch DescriptionTitle.stringValue {
            case "Overview" :
                var detail : NSViewController
                if self.detail != nil {
                    detail = self.detail!
                } else {
                    detail = DetailContentScroll.init(nibName: "DetailContentScroll", bundle: nil)
                }
                self.stack!.addArrangedSubview(detail.view)
                self.stack!.setCustomSpacing(0, after: self.view)
                self.detail = detail
                self.expanded = true
            default :
                break
            }
        } else {
            self.stack!.removeView(self.detail!.view)
            self.expanded = false
        }
    }
    
    func setTitle(title : String) {
        DescriptionTitle.stringValue = title
    }
    
    func setStack(stack : flippedView) {
        self.stack = stack
    }
}
