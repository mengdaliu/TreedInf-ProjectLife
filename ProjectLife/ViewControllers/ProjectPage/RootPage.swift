//
//  RootPage.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/31.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class RootPage: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        holder.borderType = .noBorder
        holder.boxType = .custom
        let verticalStack = VerticalStack.init(nibName: "VerticalStack", bundle: nil)
        verticalStack.setLevel(level: 0)
        holder.contentView = verticalStack.view
        self.addChild(verticalStack)
        verticalStack.add.button.isEnabled = false
        verticalStack.add.button.isHidden = true
        NSLayoutConstraint.init(item: verticalStack.view, attribute: .top, relatedBy: .equal, toItem: holder, attribute: .top, multiplier: 1, constant: 0).isActive = true
        let ProjectLife = projectStack.init(nibName: "projectStack", bundle: nil)
        self.addChild(ProjectLife)

        
        let nickName = dalGlobal.userInfo?.nickname
        let title = nickName! + "'s Project Life"
        verticalStack.addProjectItem(VC: ProjectLife)
        ProjectLife.pTitle.setStringValue(string: title)
    }
    
    @IBOutlet weak var holder: NSBox!
}
