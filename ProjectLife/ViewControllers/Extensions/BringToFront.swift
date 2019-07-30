//
//  BringToFront.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/30.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Foundation
import Cocoa

extension NSView {
    
    func bringSubviewToFront(_ view: NSView) {
        var theView = view
        self.sortSubviews({(viewA,viewB,rawPointer) in
            let view = rawPointer?.load(as: NSView.self)
            
            switch view {
            case viewA:
                return ComparisonResult.orderedDescending
            case viewB:
                return ComparisonResult.orderedAscending
            default:
                return ComparisonResult.orderedSame
            }
        }, context: &theView)
    }
    
}
