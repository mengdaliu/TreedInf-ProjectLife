//
//  ColorGetter.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/23.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Foundation
import Cocoa


class ColorGetter {
    static func getCurrentThemeColor() -> NSColor {
        do {
            let loadedData = UserDefaults.standard.data(forKey: "Theme Color")
            if loadedData == nil {
                return NSColor.black
            }
            let loadedColor =  try? NSKeyedUnarchiver.unarchivedObject(ofClasses : [NSColor.self], from: loadedData!) as? NSColor
            if loadedColor != nil {
                return loadedColor!
            } else {
                return NSColor.black
            }
        }
    }
}
