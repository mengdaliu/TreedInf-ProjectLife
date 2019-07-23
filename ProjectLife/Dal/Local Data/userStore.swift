//
//  userStore.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/23.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Foundation
import Cocoa


class userStore {
    
    static var appDelegate = NSApp.delegate as! AppDelegate
    static var container = appDelegate.persistentContainer
    static var defaultUrl = NSPersistentContainer.defaultDirectoryURL()
   
    
    static func getUserStore(id: String) -> (Bool, NSPersistentStore?) {
        
        let url = defaultUrl.appendingPathComponent(NSString.init(format: "%@.sqlite", id) as String)
        var store = container.persistentStoreCoordinator.persistentStore(for: url)
        
        if store == nil {
            store = userStore.setUserStore(id: id)
            return (false, store)
        } else {
            return (true, store)
        }
    }
    
    
    static func setUserStore(id : String) -> NSPersistentStore? {
        
        let url = defaultUrl.appendingPathComponent(NSString.init(format: "%@.sqlite", id) as String)
        do {
            return try container.persistentStoreCoordinator.addPersistentStore(ofType: "SQLite", configurationName: nil, at: url, options: nil)
        } catch {
            return nil
        }
    }
    
    static func setNickName() {
        
    }
}
