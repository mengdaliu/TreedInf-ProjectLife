//
//  addButton.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/5.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class addButton: NSViewController {

    @IBOutlet weak var button: HoverButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        button.bezelStyle = .regularSquare
        button.font = .labelFont(ofSize: 20)
        var color = ColorGetter.getCurrentThemeColor()
        if color == ThemeColor.white {
            color = ThemeColor.black
        }
        button.setText(str: "+ New Project", color: color )
        button.wantsLayer = true
        button.layer?.backgroundColor = .init(red: 0.83, green: 0.87, blue: 0.83, alpha: 0.95)
        button.showsBorderOnlyWhileMouseInside  = true
        button.layer?.masksToBounds =  true
        button.layer?.cornerRadius = 20
    }
    
    func handleChangeColor(color : NSColor) {
        button.setText(str: "+ New Project", color: color)
    }
    @IBAction func add(_ sender: NSButtonCell) {
        (self.parent! as! VerticalStack).addProjectItem()
    }
    
}
