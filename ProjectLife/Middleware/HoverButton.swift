//
//  HoverButton.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/16.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class HoverButton: NSButton {
    var trackingArea:NSTrackingArea!
    var hoverBackgroundColor: NSColor = NSColor.gray
    var originalBackgroundColor: NSColor = NSColor.white
    var hoverBackgroundImage: NSImage!
    var originalBackgroundImage: NSImage!
    var attributedStr: NSMutableAttributedString!
    
    // MARK: - Initializers
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        // set tracking area
        let opts: NSTrackingArea.Options = ([NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.activeAlways])
        trackingArea = NSTrackingArea(rect: bounds, options: opts, owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // set tracking area
        let opts: NSTrackingArea.Options = ([NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.activeAlways])
        trackingArea = NSTrackingArea(rect: bounds, options: opts, owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
    }
    
    // MARK: mouse events
    override func mouseEntered(with Event: NSEvent) {
        //self.layer?.backgroundColor = .white
        //cell.image = hoverBackgroundImage
    }
    
    override func mouseExited(with Event: NSEvent) {
    }

    
    // MARK: background setters
    func setImages(bgColor: NSColor, imageOriginal: NSImage, imageHover: NSImage) {
        self.hoverBackgroundColor = bgColor
        self.originalBackgroundColor = bgColor
        self.originalBackgroundImage = imageOriginal
        self.hoverBackgroundImage = imageHover
    }
    
    func setColors(originalBgColor: NSColor, hoverBgColor:NSColor) {
        self.hoverBackgroundColor = hoverBgColor
        self.originalBackgroundColor = originalBgColor
        self.originalBackgroundImage = nil
        self.hoverBackgroundImage = nil
    }
    

    
    func setText(str: String, color: NSColor) {
        attributedStr = NSMutableAttributedString(string: str)
        attributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: 0, length:attributedStr.length))
        self.attributedTitle = attributedStr
    }
    
    
}
