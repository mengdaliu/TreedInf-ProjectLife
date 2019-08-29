//
//  deleteConfirmation.swift
//  ProjectLife
//
//  Created by 刘梦达 on 2019/8/21.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class deleteConfirmation: NSViewController {

    @IBOutlet weak var firstLine: NSTextFieldCell!
    var projToDelete : Project!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func forProject(proj : Project) {
        
        projToDelete = proj
    }
    
    override func viewDidAppear() {
        if projToDelete.title != nil {
            firstLine.stringValue = "Are you sure you want to delete " + "\'" + projToDelete.title! + "\'?"
        }
    }
    
    @IBAction func pressYes(_ sender: Any) {
        if project.getState(for: projToDelete) == nil {
            if (self.parent!.parent!.parent as! VerticalStack).selected == (self.parent!.parent as! projectStack) {
                 (self.parent!.parent!.parent!.parent as! VerticalSplit).removeChildren(current: (self.parent!.parent!.parent! as! VerticalStack))
            }
            (self.parent!.parent!.parent as! VerticalStack).handleDelete(item: self.parent!.parent as! projectStack)
            
        } else {
            if (self.parent!.parent!.parent!.parent!.parent! as! VerticalStack).selected == (self.parent!.parent!.parent as! projectStack) {
                (self.parent!.parent!.parent!.parent!.parent!.parent as! VerticalSplit).removeChildren(current: (self.parent!.parent!.parent!.parent!.parent as! VerticalStack))
            }
            (self.parent!.parent!.parent!.parent as! ArchivedStack).handleDelete(item: self.parent!.parent!.parent as! projectStack)
        }
        self.removeFromParent()
        self.dismiss(nil)
    }
    
    
    @IBAction func pressCancal(_ sender: Any) {
        self.removeFromParent()
        self.dismiss(nil)
    }
}
