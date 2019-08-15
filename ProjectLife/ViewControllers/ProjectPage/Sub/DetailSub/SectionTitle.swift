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
                var detail : DetailContentScroll
                if self.detail != nil {
                    detail = self.detail! as! DetailContentScroll
                    (self.parent as! SectionStack).Stack.addArrangedSubview(detail.view)
                    self.parent?.addChild(detail)
                } else {
                    detail = DetailContentScroll.init(nibName: "DetailContentScroll", bundle: nil)
                    (self.parent as! SectionStack).Stack.addArrangedSubview(detail.view)
                    self.parent?.addChild(detail)
                    if (self.parent!.parent!.parent as! projectStack).p.overview != nil {
                        detail.textField!.string = (self.parent!.parent!.parent as! projectStack).p.overview!
                    }
                }
                (self.parent as! SectionStack).Stack.setCustomSpacing(0, after: self.view)
                self.detail = detail
                self.expanded = true
            default :
                break
            }
        } else {
            (self.parent as! SectionStack).Stack.removeView(self.detail!.view)
            self.expanded = false
        }
    }
    
    func expandAndEditOverview(){
        clickDisclosure(self.ClosureTriangle)
        self.ClosureTriangle.state = .on
        self.view.window?.makeFirstResponder((self.detail as! DetailContentScroll).textField)
    }
    
    func setTitle(title : String) {
        DescriptionTitle.stringValue = title
    }
    
    func setStack(stack : flippedView) {
        self.stack = stack
    }
}
