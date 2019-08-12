//
//  addButton.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/11.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class add: NSViewController {

    @IBOutlet weak var button: HoverButton!
    var forSection : String?
    
    func set(for section : String) {
        self.forSection = section
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        button.bezelStyle = .smallSquare
        button.font = .labelFont(ofSize: 30)
        if self.forSection == "Plans" {
            button.setText(str: "+", color: ThemeColor.red)
        } else {
            button.setText(str: "+", color: ThemeColor.green)
        }
        //button.wantsLayer = true
        //button.layer?.backgroundColor = .init(red: 0.83, green: 0.87, blue: 0.83, alpha: 0.95)
        button.showsBorderOnlyWhileMouseInside  = true
        button.layer?.masksToBounds =  true
        button.layer?.cornerRadius = 5
    }

    @IBAction func add(_ sender: Any) {
        if self.forSection == "Plans" {
            print(1)
            (self.parent as! dailyPlan).handleNewEdit()
        }
    }
}
