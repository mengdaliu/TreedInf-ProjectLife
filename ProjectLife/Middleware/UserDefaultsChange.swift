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
        
        if lineDrawer.instance != nil {
            lineDrawer.instance?.changeLineColor(color : color)
        }
        
        if Enter.instance != nil {
            Enter.instance?.changeGreetingLineColor(color : color)
        }
        if FrontPagePhoto.instance != nil {
            FrontPagePhoto.instance?.changePhotoOpacity(color : color)
        }
        
        if NickName.instance != nil {
            NickName.instance?.changeQuestionColor(color: color)
        }
        
        
        
        
        
        var c : NSColor!
        if color == ThemeColor.white {
            c = ThemeColor.black
        } else {
            c = color
        }
        
        if signInWeb.instance != nil {
            signInWeb.instance?.changeButtonColor(color: c)
        }
        
        if ViewController.instance != nil {
            ViewController.instance?.changeTabColor(color: c)
        }

        if VerticalSplit.instance != nil {
            VerticalSplit.instance?.changeDividerColor(color: c)
            VerticalSplit.instance?.changeTitleColor(color: c)
        }
        
        if DaysMaster.instance != nil {
            DaysMaster.instance!.handleChangeColor(color : c)
        }
        
     
    }
    
}
