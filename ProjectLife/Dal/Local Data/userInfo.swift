//
//  userStore.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/23.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Foundation
import Cocoa


class userInfo {
    
    static var appDelegate = NSApp.delegate as! AppDelegate
    static var container = appDelegate.persistentContainer
    static var defaultUrl = NSPersistentContainer.defaultDirectoryURL()
    static var context = container.viewContext

    
    static func getUserStore(id: String) -> (Bool, NSPersistentStore?) {
        
        let url = defaultUrl.appendingPathComponent(NSString.init(format: "%@.sqlite", id) as String)
        var store = container.persistentStoreCoordinator.persistentStore(for: url)
        
        if store == nil {
            store = userInfo.setUserStore(id: id)
            dalGlobal.userStore = store
            return (false, store)
        } else {
            dalGlobal.userStore = store
            return (true, store)
        }
    }
    
    
    static func setUserStore(id : String) -> NSPersistentStore? {
        
        let url = defaultUrl.appendingPathComponent(NSString.init(format: "%@.sqlite", id) as String)
        do {
            let userStore = try container.persistentStoreCoordinator.addPersistentStore(ofType: "SQLite", configurationName: nil, at: url, options: nil)
            return userStore
        } catch {
            return nil
        }
    }
    
    static func setNickName(nickName: String) {
       dalGlobal.userInfo?.nickname = nickName
        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    static func createUserInfoObject(id : String) {
         let info = NSEntityDescription.insertNewObject(forEntityName: "UserInfo", into: context) as! UserInfo
         info.id = id
         dalGlobal.userInfo = info
        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    static func setStartTime(time: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: time)
        dalGlobal.userInfo?.startTime = dateString
        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    static func setEndTime(time: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: time)
        dalGlobal.userInfo?.endTime = dateString
        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    static func setPlan(plan: String) {
        dalGlobal.userInfo?.plan = plan
        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
}
