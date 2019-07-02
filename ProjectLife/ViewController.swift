//
//  ViewController.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/2.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        headerView.boxType = .custom
        headerView.alphaValue = 1
        headerView.borderType = .noBorder
        headerView.wantsLayer = true
        headerView.layer?.backgroundColor = NSColor.lightGray.cgColor
    }

    
    @IBOutlet weak var headerView: NSBox!
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

