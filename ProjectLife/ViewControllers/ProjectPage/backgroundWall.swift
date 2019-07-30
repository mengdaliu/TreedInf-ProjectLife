//
//  backgroundWall.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/30.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class backgroundWall: NSViewController {
    

    
    static var instance : backgroundWall?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        wallPic.imageScaling = .scaleNone
        wallPic.imageFrameStyle = .photo
        wallPic.alphaValue = 1

       
        wallPic.image = WallPaper.linen
        
        backgroundWall.instance = self
    }
    
    @IBOutlet weak var wallPic: NSImageView!
}
