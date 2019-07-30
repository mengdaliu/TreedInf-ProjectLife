//
//  ThemeColor.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/12.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Foundation
import Cocoa

class ThemeColor {
    static var blue = NSColor.init(calibratedRed: CGFloat(0), green: (0.07), blue: CGFloat(0.21), alpha: CGFloat(1))
    static var brown = NSColor.init(calibratedRed: CGFloat(0.2), green: CGFloat(0.1), blue: CGFloat(0.03), alpha: CGFloat(1))
    static var grey = NSColor.init(calibratedRed: CGFloat(0.15), green: CGFloat(0.15), blue: CGFloat(0.15), alpha: CGFloat(1))
    static var red = NSColor.init(calibratedRed: CGFloat(0.3), green: CGFloat(0), blue: CGFloat(0), alpha: CGFloat(1))
    static var green = NSColor.init(calibratedRed: CGFloat(0.08), green: CGFloat(0.15), blue: CGFloat(0.075), alpha: CGFloat(1))
    static var white = NSColor.init(calibratedRed: CGFloat(1), green: CGFloat(1), blue: CGFloat(1), alpha: CGFloat(1))
    static var peru = NSColor.init(calibratedRed: CGFloat(0.21), green: CGFloat(0.145), blue: CGFloat(0.04), alpha: CGFloat(1))
    static var black = NSColor.init(calibratedRed: CGFloat(0), green: CGFloat(0), blue: CGFloat(0), alpha: CGFloat(1))
}

class WallPaper {
    
    static let picSize = NSScreen.main?.frame.size
    static let w = picSize?.width
    static let h = picSize?.height
    static var linen = NSImage.init(contentsOf: URL( string: NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", "https://images.unsplash.com/photo-1528458909336-e7a0adfed0a5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9", w!, h! - 55) as String)!)
    static var blackCat = NSImage.init(contentsOf: URL( string: NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", "https://images.unsplash.com/photo-1496517741878-4c0af85f0991?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9", w!, h! - 55) as String)!)
}


