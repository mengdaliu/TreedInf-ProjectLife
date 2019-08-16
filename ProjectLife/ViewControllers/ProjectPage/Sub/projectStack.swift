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
    var p : Project!
    var firstTime = true
    var childrenVC : VerticalStack?
    var deactivated = false
    var optionVC : optionWrapper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let title = projectTitle.init(nibName: "projectTitle", bundle: nil)
        self.Stack.addArrangedSubview(title.view)
        self.pTitle = title
        self.addChild(title)
    }
    
    func handleDropDownDetail(VC: projectDetail){
        
        if firstTime {
            self.Stack.addArrangedSubview(VC.view)
            self.Stack!.setCustomSpacing(0, after: self.pTitle.view)
            self.addChild(VC)
            self.pDetail = VC
            
            VC.view.isHidden = false
            self.view.layoutSubtreeIfNeeded()
            self.Stack!.removeView(pDetail.view)
            self.view.layoutSubtreeIfNeeded()
            
            firstTime = false
        }
        
        
        self.Stack.addArrangedSubview(VC.view)
        self.Stack!.setCustomSpacing(0, after: self.pTitle.view)
        self.addChild(VC)
        self.pDetail = VC
       
        NSAnimationContext.runAnimationGroup({context in
            context.duration = 0.2
            context.allowsImplicitAnimation = true
            
            VC.view.isHidden = false
            self.view.layoutSubtreeIfNeeded()
           
        }, completionHandler: nil)
        
    }
    
    func handleCollapseDetail() {
        self.Stack!.removeView(pDetail.view)
    }
    
    func setTitle(title : String) {
        self.pTitle.setStringValue(string: title)
    }
    
    func returnNormal() {
        self.pTitle.returnNormal()
        self.pTitle.loadedChildren = false
    }
    
    func handleSetName(title : String) {
        project.setTitle(for: self.p, title: title)
    }
    
    func handleLoadOptions(){
        if optionSetterGlobal.selectedProjectStack != nil {
            optionSetterGlobal.selectedProjectStack?.handleCollapseOptions()
            optionSetterGlobal.selectedProjectStack?.pTitle.expandedOptions = false 
        }
        
        optionSetterGlobal.selectedProjectStack = self
        
        if !self.deactivated {
            let options = optionWrapper.init(nibName: "optionWrapper", bundle: nil)
            self.Stack!.insertArrangedSubview(options.view, at: 1)
            self.Stack!.setCustomSpacing(0, after: self.pTitle.view)
            self.Stack!.setCustomSpacing(0, after: options.view)
            self.addChild(options)
            options.view.translatesAutoresizingMaskIntoConstraints = false 
            options.setUpForActiveProject()
            self.optionVC = options
        } else {
            let options = optionWrapper.init(nibName: "optionWrapper", bundle: nil)
            self.Stack!.insertArrangedSubview(options.view, at: 1)
            self.Stack!.setCustomSpacing(0, after: options.view)
            self.addChild(options)
            options.setUpForDeactivatedProject()
            self.optionVC = options
        }
        
    }
    
    func handleCollapseOptions(){
        self.Stack!.removeView(self.optionVC!.view)
        self.optionVC?.removeFromParent()
    }
    
}
