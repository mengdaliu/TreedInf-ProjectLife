//
//  projectStack.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/5.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class projectStack: NSViewController {

    @IBOutlet weak var Stack: flippedView!
    var pTitle : projectTitle!
    var pDetail : projectDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let title = projectTitle.init(nibName: "projectTitle", bundle: nil)
        self.Stack.addArrangedSubview(title.view)
        self.pTitle = title
        self.addChild(title)
       
    }
    
    func handleDropDownDetail(VC: projectDetail){
        self.Stack.addArrangedSubview(VC.view)
        self.Stack!.setCustomSpacing(0, after: self.pTitle.view)
        self.addChild(VC)
        self.pDetail = VC
    }
    
    func handleCollapseDetail() {
        self.Stack!.removeView(self.pDetail.view)
    }

    
}
