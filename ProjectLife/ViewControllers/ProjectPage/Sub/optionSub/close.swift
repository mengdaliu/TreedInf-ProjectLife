//
//  Archive.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/15.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class close: NSViewController {

    @IBOutlet weak var deleteButton: HoverButton!
    @IBOutlet weak var archiveButton: HoverButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = .init(gray: 0.9, alpha: 0.8)
        
        archiveButton.font = .labelFont(ofSize: 18)
        deleteButton.font = .labelFont(ofSize: 18)
        archiveButton.setText(str: "Archive", color: ThemeColor.brown)
        deleteButton.setText(str: "Delete", color: ThemeColor.red)
        
        NSLayoutConstraint.init(item: deleteButton!, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: archiveButton, attribute: .leading, multiplier: 1, constant: -1).isActive = true
        
        archiveButton.showsBorderOnlyWhileMouseInside = true
        deleteButton.showsBorderOnlyWhileMouseInside = true
    }
    
    @IBAction func pressArchive(_ sender: Any) {
        let projectToDeactivate = (self.parent as! projectStack).p!
         (self.parent!.parent as! VerticalStack).deactivate(projectStack: self.parent! as! projectStack)
         (self.parent! as! projectStack).handleCollapseOptions()
         project.deactivate(proj: projectToDeactivate)
         optionSetterGlobal.selectedProjectStack = nil
    }
    
    @IBAction func pressDelete(_ sender: Any) {
        let deleteWindow = deleteConfirmation.init(nibName: "deleteConfirmation", bundle: nil)
        deleteWindow.forProject(proj: (self.parent as! projectStack).p)
        self.presentAsSheet(deleteWindow)
        self.addChild(deleteWindow)
    }
    
}
