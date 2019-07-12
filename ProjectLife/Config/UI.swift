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
    static var blue = [0, 0.07, 0.21, 1]
    static var brown = [0.2775, 0.09, 0.03, 1]
    static var grey =  [0.15, 0.15, 0.15, 1]
    static var red = [0.3, 0, 0, 1]
    static var green = [0.09, 0.15, 0.075, 1]
    static var white =  [1.0, 1.0, 1.0, 1]
    static var peru =  [0.21, 0.14, 0.05, 1]
    static var black =  [0.0, 0.0, 0.0, 1]
}

enum FrontPageStyle {
    case Pure
    case Passion
}

class UIConfigs {
    static var maxSize = NSSize.init()
}

