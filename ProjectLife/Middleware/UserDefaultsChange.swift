//
//  UserDefaultsChange.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/16.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Foundation
import Cocoa

class UIPerferenceChange {
    static func ThemeColorHasChanged(color : NSColor) {
        if SignIn.instance != nil {
            SignIn.instance?.changeButtonColor(color: color)
        }
        
        if signInWeb.instance != nil {
            signInWeb.instance?.changeButtonColor(color: color)
        }
    }
}
