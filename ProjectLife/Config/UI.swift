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
    static var linen = NSImage.init(contentsOf: URL( string: NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", "https://images.unsplash.com/photo-1528458909336-e7a0adfed0a5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9", w!, h! - 33) as String)!)
    static var blackCat = NSImage.init(contentsOf: URL( string: NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", "https://images.unsplash.com/photo-1496517741878-4c0af85f0991?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9", w!, h! - 33) as String)!)
    static var blue = NSImage.init(contentsOf: URL( string: NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", "https://images.unsplash.com/photo-1487088678257-3a541e6e3922?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9", w!, h! - 33) as String)!)
    static var concrete = NSImage.init(contentsOf: URL( string: NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", "https://images.unsplash.com/photo-1523878288860-7ad281611901?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9", w!, h! - 33) as String)!)
    static var blackAndWhite = NSImage.init(contentsOf: URL( string: NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", "https://images.unsplash.com/photo-1505562130589-9879683e72da?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9", w!, h! - 33) as String)!)
    static var broken = NSImage.init(contentsOf: URL( string: NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", "https://images.unsplash.com/photo-1533738630286-f1f4a61705f8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9", w!, h! - 33) as String)!)
    static var bricks = NSImage.init(contentsOf: URL( string: NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", "https://images.unsplash.com/photo-1531481517150-2228446fb6b0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9", w!, h! - 33) as String)!)
    static var light = NSImage.init(contentsOf: URL( string: NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", "https://images.unsplash.com/photo-1494438639946-1ebd1d20bf85?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9", w!, h! - 33) as String)!)
    static var inkWash = NSImage.init(contentsOf: URL( string: NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", "https://images.unsplash.com/photo-1531811027466-d90d527b4424?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9", w!, h! - 33) as String)!)
    static var doodle = NSImage.init(contentsOf: URL( string: NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", "https://images.unsplash.com/photo-1465533403411-0af6ede250dd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9", w!, h! - 33) as String)!)
    static var window = NSImage.init(contentsOf: URL( string: NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", "https://images.unsplash.com/photo-1533389816032-1d4660b2d1b5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9", w!, h! - 33) as String)!)
    static var modern = NSImage.init(contentsOf: URL( string: NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", "https://images.unsplash.com/photo-1453814235491-3cfac3999928?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9", w!, h! - 33) as String)!)
    static var brownPaper = NSImage.init(contentsOf: URL( string: NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", "https://images.unsplash.com/photo-1538645731800-4640c639bba7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9", w!, h! - 33) as String)!)
    static var vases = NSImage.init(contentsOf: URL( string: NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", "https://images.unsplash.com/photo-1503933190776-da31c7700f80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9", w!, h! - 33) as String)!)
     static var door = NSImage.init(contentsOf: URL( string: NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", "https://images.unsplash.com/photo-1481277542470-605612bd2d61?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9", w!, h! - 33) as String)!)
}


