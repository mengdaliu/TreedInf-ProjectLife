//
//  project.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/6.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Foundation
import Cocoa

class project {
    
    static var appDelegate = NSApp.delegate as! AppDelegate
    static var container = appDelegate.persistentContainer
    static var defaultUrl = NSPersistentContainer.defaultDirectoryURL()
    static var context = dalGlobal.context
    
    static func setUpProjectLife(){
        let req = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Project")
        req.affectedStores = [dalGlobal.userStore!]
        do {
            let gotData = try context!.fetch(req)
            if gotData.count < 1 {
                createProjectLifeObject()
            } else {
                dalGlobal.projectLife = gotData[0] as? Project
            }
        } catch {
            fatalError("Failure to fetch from context: \(error)")
        }
        //treeTraversal(from: dalGlobal.projectLife!)
    }
    
    
    
    static func createProjectLifeObject(){
        let projectLife = NSEntityDescription.insertNewObject(forEntityName: "Project", into: context!) as! Project
        context!.assign(projectLife, to: dalGlobal.userStore!)
        //projectLife.title = dalGlobal.userInfo!.nickname! + "' " + "Project Life"
        dalGlobal.projectLife = projectLife
        do {
            try context!.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    static func newProject(for parentProject : Project, title : String) -> Project {
        let project =  NSEntityDescription.insertNewObject(forEntityName: "Project", into: context!) as! Project
        context!.assign(project, to: dalGlobal.userStore!)
        project.title = title
        project.parent = parentProject
        parentProject.addToSubProjects(project)
        do {
            try context!.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        return project
    }
    
    static func setTitle(for proj: Project, title : String) {
        proj.title = title
        
        do {
            try context!.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    
    
    
    static func setOverview(for proj: Project, overview : String) {
        proj.overview = overview
        
        do {
            try context!.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    
    static func delete(proj : Project) {
    
        proj.parent!.removeFromSubProjects(proj)
        
        do {
            try context!.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    static func getParent(for proj: Project) -> Project {
        return proj.parent!
    }
    
    static func getChildren(for proj : Project) -> [Project]? {
        if proj.subProjects != nil {
            return Array(proj.subProjects!) as? [Project]
        } else {
            return nil
        }
        
    }
    
    static func getDescription(for proj : Project) -> String? {
        return proj.description
    }
    
    static func setState(for proj : Project, state : String) {
        proj.state = state
    }
    
    static func getState(for proj: Project) -> String? {
        return proj.state
    }
    
    static func moveUp(proj : Project) {
        var front : [Project] = []
        var tail : [Project] = []
        var found = false
        for p in (Array(proj.parent!.subProjects ?? []) as! [Project]) {
            if found { //found之后
                 tail.append(p)
            } else if p != proj { //found之前
                 front.append(p)
            } else { //found当时
                if front.count >= 1 {
                    let last = front[front.count - 1]
                    front.remove(at: front.count - 1)
                    tail.append(last)
                    front.append(p)
                    found = true
                } else {
                    front.append(p)
                    found = true
                }
            }
        }
        front.append(contentsOf: tail)
        proj.parent!.subProjects = NSOrderedSet.init(array: front)
        do {
            try context!.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    static func moveDown(proj : Project) {
        var new : [Project] = []
        var flip = false
        for p in (Array(proj.parent!.subProjects ?? []) as! [Project]) {
            if flip {
                flip = false
                new.remove(at: new.count - 1)
                new.append(p)
                new.append(proj)
            } else if proj != p {
                new.append(p)
            } else {
                new.append(p)
                flip = true
            }
        }
        
        proj.parent!.subProjects = NSOrderedSet.init(array: new)
        
        do {
            try context!.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    static func moveToParentLevel(proj : Project) {
        let parent = proj.parent
        parent!.removeFromSubProjects(proj)
        let grandParent = parent!.parent
        grandParent?.addToSubProjects(proj)
        
        do {
            try context!.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
    }
    
    static func move(proj : Project, toChildLevelOf newParent: Project) {
        let parent = proj.parent
        parent!.removeFromSubProjects(proj)
        newParent.addToSubProjects(proj)
        
        do {
            try context!.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
}


class projectHistory {
    
    static var appDelegate = NSApp.delegate as! AppDelegate
    static var container = appDelegate.persistentContainer
    static var defaultUrl = NSPersistentContainer.defaultDirectoryURL()
    static var context = dalGlobal.context
    
    static func getHistory(for proj : Project, on day : Date) -> ProjectHistory {
        let history = NSArray(object : proj.history ?? [])
        let filteringPredicate = NSPredicate.init(format: "date == %@", argumentArray: [day])
        let result = history.filtered(using: filteringPredicate)
        if result.count > 0 {
            return result[0] as! ProjectHistory
        } else {
            return createHistory(for: proj, on: day)
        }
    }
    
    static func createHistory(for proj : Project, on day : Date) -> ProjectHistory {
        let history = NSEntityDescription.insertNewObject(forEntityName: "ProjectHistory", into: context!) as! ProjectHistory
        history.date = day
        proj.addToHistory(history)
        context!.assign(history, to: dalGlobal.userStore!)
        do {
            try context!.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        return history
    }
    
    static func set(action : Action, for history : ProjectHistory) {
        history.addToAction(action)
        do {
            try context!.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    
    static func createAction(type : String, plan : Plan?, done : Done?) -> Action {
        let act = NSEntityDescription.insertNewObject(forEntityName: "Action", into: context!) as! Action
        act.type = type
        if act.type == "Plan" {
            act.plan = plan
        } else if act.type == "Done" {
            act.done = done
        }
        context!.assign(act, to: dalGlobal.userStore!)
        
        do {
            try context!.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        return act
    }
}


