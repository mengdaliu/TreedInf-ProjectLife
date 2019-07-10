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
        mainView.boxType = .custom
        mainView.alphaValue = 1
        mainView.borderType = .noBorder
        mainView.wantsLayer = true
        mainView.layer?.backgroundColor = CGColor.init(red: CGFloat(0.9), green: CGFloat(0.9), blue: CGFloat(0.9), alpha: CGFloat(1))
        
        
        let photoController = FrontPagePhoto.init(nibName: "FrontPagePhoto", bundle: nil)
        self.addChild(photoController)
        mainView.contentView = photoController.view
    
    }

    @IBOutlet weak var mainView: NSBox!

}

