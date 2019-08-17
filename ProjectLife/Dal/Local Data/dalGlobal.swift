//
//  dalConfig.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/28.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Foundation
import Cocoa

class dalGlobal {
    static var userStore : NSPersistentStore?
    static var userInfo : UserInfo?
    static var projectLife : Project?
    static var appDelegate = NSApp.delegate as! AppDelegate
    static var container = appDelegate.persistentContainer
    static var context : NSManagedObjectContext!
    
    static func setUp() {
        dalGlobal.context = dalGlobal.container.newBackgroundContext()
    }
}
