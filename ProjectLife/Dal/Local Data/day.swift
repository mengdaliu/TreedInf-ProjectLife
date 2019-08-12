//
//  day.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/11.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Foundation
import Cocoa

class day {
    
    static var appDelegate = NSApp.delegate as! AppDelegate
    static var container = appDelegate.persistentContainer
    static var defaultUrl = NSPersistentContainer.defaultDirectoryURL()
    static var context = container.newBackgroundContext()
    
    static func loadDays() -> [Day]? {
        let req = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Day")
        req.affectedStores = [dalGlobal.userStore!]
        do {
            let gotData = try context.fetch(req)
            if gotData.count < 1 {
                return nil
            } else {
                return gotData as? [Day]
            }
        } catch {
            return nil 
        }
    }
    
    static func Add(day : Date) -> Day {
        let date = NSEntityDescription.insertNewObject(forEntityName: "Day", into: context) as! Day
        context.assign(date, to: dalGlobal.userStore!)
        date.date = day
        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        return date
    }
    
    static func Add(plan : Plan, to day: Day) {
        day.addToPlans(plan)
        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    static func Add(done : Done, to day: Day) {
        day.addToDones(done)
        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    static func getPlan(from day : Day) -> [Plan]? {
        if day.plans == nil {
            return nil
        } else {
            return Array(day.plans!) as? [Plan]
        }
    }
    
    static func getDone(from day : Day) -> [Done]? {
        if day.dones == nil {
            return nil
        } else {
            return Array(day.dones!) as? [Done]
        }
    }
    
    static func delete(plan : Plan) {
        context.delete(plan)
        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    static func delete(done : Done) {
        context.delete(done)
        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    static func deleteAllDays() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Day")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.affectedStores = [dalGlobal.userStore!]
        do {
            try container.persistentStoreCoordinator.execute(deleteRequest, with: context)
        } catch  {
        }

    }
}


class plan {
    
    static var appDelegate = NSApp.delegate as! AppDelegate
    static var container = appDelegate.persistentContainer
    static var defaultUrl = NSPersistentContainer.defaultDirectoryURL()
    static var context = container.newBackgroundContext()
    
    static func newPlan() -> Plan {
        let plan = NSEntityDescription.insertNewObject(forEntityName: "Plan", into: context) as! Plan
        context.assign(plan, to: dalGlobal.userStore!)
        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        return plan
    }
    
    static func set(proj : Project, for plan : Plan) {
        plan.project = proj
    }
    
    static func set(percentage : Int16, for plan : Plan) {
        plan.percentage = percentage
    }
    
    static func set(comment : String, for plan : Plan) {
        plan.comment = comment
    }
}

class done {
    
    static var appDelegate = NSApp.delegate as! AppDelegate
    static var container = appDelegate.persistentContainer
    static var defaultUrl = NSPersistentContainer.defaultDirectoryURL()
    static var context = container.newBackgroundContext()
    
    static func newDone() -> Done {
        let done = NSEntityDescription.insertNewObject(forEntityName: "Day", into: context) as! Done
        context.assign(done, to: dalGlobal.userStore!)
        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        return done
    }
    
    static func set(proj : Project, for done : Done) {
        done.project = proj
    }
    
    static func set(percentage : Int16, for done : Done) {
        done.percentage = percentage
    }
    
    static func set(comment : String, for done : Done) {
        done.comment = comment
    }
}
