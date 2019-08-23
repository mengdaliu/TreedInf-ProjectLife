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
        if proj.title != nil {
            firstLine.stringValue = "Are you sure you want to delete " + "\'" + proj.title! + "\'?"
        }
        projToDelete = proj
    }
    
    @IBAction func pressYes(_ sender: Any) {
        if project.getState(for: projToDelete) == nil {
            (self.parent!.parent!.parent as! VerticalStack).handleRemove(item: self.parent!.parent as! projectStack)
        } else {
            (self.parent!.parent!.parent as! ArchivedStack).handleRemoveProject(item: self.parent!.parent as! projectStack)
        }
        project.delete(proj: self.projToDelete)
    }
}
