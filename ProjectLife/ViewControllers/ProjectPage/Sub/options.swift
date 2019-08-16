//
//  options.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/15.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class options: NSViewController {

    @IBOutlet weak var plan: HoverButton!
    @IBOutlet weak var work: HoverButton!
    @IBOutlet weak var archive: HoverButton!
    var droppedDownSetter : NSViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = .init(gray: 0.9, alpha: 0.8)
        plan.translatesAutoresizingMaskIntoConstraints = false
        plan.font = .labelFont(ofSize: 18)
        plan.showsBorderOnlyWhileMouseInside = true
        work.translatesAutoresizingMaskIntoConstraints = false
        work.font = .labelFont(ofSize: 18)
        work.showsBorderOnlyWhileMouseInside = true
        archive.translatesAutoresizingMaskIntoConstraints = false
        archive.font = .labelFont(ofSize: 18)
        archive.showsBorderOnlyWhileMouseInside = true 
        plan.setText(str: "Plan For Day", color: ThemeColor.red)
        work.setText(str: "Record Work For Day", color: ThemeColor.green)
        archive.setText(str: "Archive", color: ThemeColor.blue)
    }
    
    @IBAction func plan(_ sender: Any) {
        let p = planForDay.init(nibName: "planForDay", bundle: nil)
        p.view.translatesAutoresizingMaskIntoConstraints = false 
        (self.parent!.parent as! projectStack).Stack.insertArrangedSubview(p.view, at: 2)
        (self.parent!.parent as! projectStack).addChild(p)
        (self.parent!.parent as! projectStack).Stack.setCustomSpacing(0, after: p.view)
    }
    
    @IBAction func work(_ sender: Any) {
    }
    
    @IBAction func archive(_ sender: Any) {
    }
    
}
