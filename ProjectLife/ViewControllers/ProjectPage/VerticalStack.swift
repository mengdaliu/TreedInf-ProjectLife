//
//  VerticalStack.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/31.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class VerticalStack: NSViewController {

    @IBOutlet weak var scroll: NSScrollView!
    
    //@IBOutlet weak var ProjectStack: NSStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let ProjectStack = NSStackView.init(frame: scroll.documentView!.frame)
        ProjectStack.orientation = .vertical
        ProjectStack.translatesAutoresizingMaskIntoConstraints = false

        
        
        //self.scroll.addSubview(ProjectStack)
        self.scroll.documentView = ProjectStack
        ProjectStack.setClippingResistancePriority(.defaultLow, for: .vertical)
        
        
        NSLayoutConstraint.init(item: ProjectStack, attribute: .top, relatedBy: .equal, toItem: scroll, attribute: .top, multiplier: 1, constant: 0).isActive = true
       
        NSLayoutConstraint.init(item: ProjectStack, attribute: .leading, relatedBy: .equal, toItem: scroll, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: ProjectStack, attribute: .trailing, relatedBy: .equal, toItem: scroll, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        print(ProjectStack.constraints)
        //scroll.addFloatingSubview(ProjectStack, for: .vertical)
        scroll.drawsBackground = false

        //scroll.addFloatingSubview(ProjectStack, for: .horizontal)
        let testView = projectTitle.init(nibName: "projectTitle", bundle: nil).view
        let testView2 = projectTitle.init(nibName: "projectTitle", bundle: nil).view
        let testView3 = projectTitle.init(nibName: "projectTitle", bundle: nil).view
        let testView4 = projectTitle.init(nibName: "projectTitle", bundle: nil).view
        let testView5 = projectTitle.init(nibName: "projectTitle", bundle: nil).view
         let testView6 = projectTitle.init(nibName: "projectTitle", bundle: nil).view
         let testView7 = projectTitle.init(nibName: "projectTitle", bundle: nil).view
         let testView8 = projectTitle.init(nibName: "projectTitle", bundle: nil).view
         let testView9 = projectTitle.init(nibName: "projectTitle", bundle: nil).view
        
        ProjectStack.addArrangedSubview(testView)
        ProjectStack.addArrangedSubview(testView2)
        ProjectStack.addArrangedSubview(testView3)
        ProjectStack.addArrangedSubview(testView4)
        ProjectStack.addArrangedSubview(testView5)
        ProjectStack.addArrangedSubview(testView6)
        ProjectStack.addArrangedSubview(testView7)
        ProjectStack.addArrangedSubview(testView8)
        ProjectStack.addArrangedSubview(testView9)
       
        var i = 0
        while i < 30 {
            ProjectStack.addArrangedSubview(projectTitle.init(nibName: "projectTitle", bundle: nil).view)
            i += 1
            
        }
        ProjectStack.alignment = .centerX
        ProjectStack.distribution = .gravityAreas
        ProjectStack.setHuggingPriority(.defaultLow, for: .vertical)
        ProjectStack.spacing = 15
        

        
        
    }

    
}
