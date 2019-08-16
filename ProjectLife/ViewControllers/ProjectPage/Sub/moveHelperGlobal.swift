//
//  moveHelperGlobal.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/14.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Foundation
import Cocoa

class moveHelperGlobal {
    static var projectTitleListening : projectTitle?
    static var commandPressed = false
    static var shiftPressed = false 
}

class detailEditingGlobal {
    static var editingTextView : NSViewController?
}

class optionSetterGlobal {
    static var selectedProjectStack : projectStack?
}
