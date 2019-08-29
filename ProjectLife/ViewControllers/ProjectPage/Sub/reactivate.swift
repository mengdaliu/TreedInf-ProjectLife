//
//  reactivate.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/15.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class reactivate: NSViewController {

    @IBOutlet weak var delete: HoverButton!
    @IBOutlet weak var reactivate: HoverButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = .init(gray: 0.9, alpha: 0.8)
        delete.translatesAutoresizingMaskIntoConstraints = false
        delete.font = .labelFont(ofSize: 18)
        delete.showsBorderOnlyWhileMouseInside = true
        reactivate.translatesAutoresizingMaskIntoConstraints = false
        reactivate.font = .labelFont(ofSize: 18)
        reactivate.showsBorderOnlyWhileMouseInside = true
        
        delete.setText(str: "Delete", color: ThemeColor.red)
        reactivate.setText(str: "Reactivate", color: ThemeColor.peru)
        
        
    }
    
    @IBAction func pressDelete(_ sender: Any) {
        let delete = deleteConfirmation.init(nibName: "deleteConfirmation", bundle: nil)
        delete.forProject(proj: (self.parent!.parent as! projectStack).p)
        self.presentAsSheet(delete)
        self.addChild(delete)
    }
    
    @IBAction func pressReactivate(_ sender: Any) {
        
        let projToReactivate = (self.parent!.parent as! projectStack).p
        let verticalStack = (self.parent!.parent!.parent!.parent as! VerticalStack)
        (self.parent!.parent!.parent as! ArchivedStack).handleReactivateProject(item: self.parent!.parent as! projectStack)
        (self.parent!.parent! as! projectStack).handleCollapseOptions()
        optionSetterGlobal.selectedProjectStack = nil
        project.reactivate(proj: projToReactivate!)
        if projToReactivate?.parent?.archivedSubProjects?.count == 0 {
            verticalStack.archivedStack = nil
        }
    }
    

}
