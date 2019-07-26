//
//  lineDrawer.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/24.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class lineDrawer: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        
        let context = NSGraphicsContext.current?.cgContext
        context!.beginPath()
        context!.move(to: CGPoint(x: self.frame.minX, y: self.frame.minY))
        let endPoint = CGPoint.init(x: self.frame.maxX, y: self.frame.minY)
        context!.addLine(to: endPoint)
        context!.move(to: CGPoint(x: 0, y: 0))
        context?.addLine(to: CGPoint(x: 10, y: 10))
        let loadedColor = ColorGetter.getCurrentThemeColor()
        context!.setStrokeColor(loadedColor.cgColor)
        context!.setLineWidth(10)
        print(context!.path)
        print(self.frame)
        context!.strokePath()
        

    }
    
}
