//
//  FrontPagePhotoViewController.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/8.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class FrontPagePhotoViewController: NSViewController {

    @IBOutlet var myView: NSView!
    
    @IBOutlet weak var backgroundImage: NSImageCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")
        // Do view setup here.
        //print("hello world")
        //self.backgroundImage.image = NSImage.init(byReferencing: URL(string:"")!)
        //self.backgroundImage.imageAlignment = NSImageAlignment.alignCenter
        //print(self.backgroundImage)
        print(myView)
        
    }

    func loadImageFromURL (address: String) {
    }

    @IBAction func test(_ sender: Any) {
        print("fuck")
        print(self)
    }
}
