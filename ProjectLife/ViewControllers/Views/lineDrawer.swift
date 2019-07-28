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
        context!.move(to: CGPoint(x: self.bounds.minX, y: self.bounds.minY))
        let endPoint = CGPoint.init(x: self.bounds.maxX, y: self.bounds.minY)
        context!.addLine(to: endPoint)
        let loadedColor = ColorGetter.getCurrentThemeColor()
        context!.setStrokeColor(loadedColor.cgColor)
        context!.setLineWidth(5)
        context!.strokePath()
    }
    
}
