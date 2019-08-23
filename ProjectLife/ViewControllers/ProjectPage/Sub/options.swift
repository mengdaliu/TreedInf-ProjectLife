//
//  options.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/15.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class options: NSViewController {

    @IBOutlet weak var plan: HoverButton!
    @IBOutlet weak var work: HoverButton!
    @IBOutlet weak var archive: HoverButton!
    var droppedDownSetter : NSViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = .init(gray: 0.9, alpha: 0.8)
        plan.translatesAutoresizingMaskIntoConstraints = false
        plan.font = .labelFont(ofSize: 18)
        plan.showsBorderOnlyWhileMouseInside = true
        work.translatesAutoresizingMaskIntoConstraints = false
        work.font = .labelFont(ofSize: 18)
        work.showsBorderOnlyWhileMouseInside = true
        archive.translatesAutoresizingMaskIntoConstraints = false
        archive.font = .labelFont(ofSize: 18)
        archive.showsBorderOnlyWhileMouseInside = true 
        plan.setText(str: "Plan For Day", color: ThemeColor.red)
        work.setText(str: "Record Work For Day", color: ThemeColor.green)
        archive.setText(str: "Close", color: ThemeColor.blue)
        if (self.parent!.parent as! projectStack).p == dalGlobal.projectLife {
            archive.isEnabled = false 
        }
       
        
    }
    
    @IBAction func plan(_ sender: Any) {
        if !plan.wantsLayer {
            if self.droppedDownSetter != nil {
                handleCollapseSetter()
            }
            let p = planForDay.init(nibName: "planForDay", bundle: nil)
            p.view.translatesAutoresizingMaskIntoConstraints = false
            (self.parent!.parent as! projectStack).Stack.insertArrangedSubview(p.view, at: 2)
            (self.parent!.parent as! projectStack).addChild(p)
            (self.parent!.parent as! projectStack).Stack.setCustomSpacing(0, after: p.view)
            self.droppedDownSetter = p
            plan.wantsLayer = true
            plan.layer?.backgroundColor = .white
            
            work.layer?.backgroundColor = .init(gray: 1, alpha: 0)
            work.wantsLayer = false
        
            archive.layer?.backgroundColor = .init(gray: 1, alpha: 0)
            archive.wantsLayer = false
            
        }
    }
    
    @IBAction func work(_ sender: Any) {
        if !work.wantsLayer {
            if self.droppedDownSetter != nil {
                handleCollapseSetter()
            }
            
            let w = planForDay.init(nibName: "planForDay", bundle: nil)
            w.forPlan = false
            w.view.translatesAutoresizingMaskIntoConstraints = false
            (self.parent!.parent as! projectStack).Stack.insertArrangedSubview(w.view, at: 2)
            (self.parent!.parent as! projectStack).addChild(w)
            (self.parent!.parent as! projectStack).Stack.setCustomSpacing(0, after: w.view)
            self.droppedDownSetter = w
            
            work.wantsLayer = true
            work.layer?.backgroundColor = .white
            archive.layer?.backgroundColor = .init(gray: 1, alpha: 0)
            archive.wantsLayer = false
            plan.layer?.backgroundColor = .init(gray: 1, alpha: 0)
            plan.wantsLayer = false
        
        }
    }
    
    @IBAction func archive(_ sender: Any) {
        if !archive.wantsLayer {
            if self.droppedDownSetter != nil {
                handleCollapseSetter()
            }
            
            let c = close.init(nibName: "close", bundle: nil)
            c.view.translatesAutoresizingMaskIntoConstraints = false
            (self.parent!.parent as! projectStack).Stack.insertArrangedSubview(c.view, at: 2)
            (self.parent!.parent as! projectStack).addChild(c)
            (self.parent!.parent as! projectStack).Stack.setCustomSpacing(0, after: c.view)
            self.droppedDownSetter = c
            
            archive.wantsLayer = true
            archive.layer?.backgroundColor = .white
            plan.layer?.backgroundColor = .init(gray: 1, alpha: 0)
            plan.wantsLayer = false
            work.layer?.backgroundColor = .init(gray: 1, alpha: 0)
            work.wantsLayer = false
            
        }
    }
    
    func handleCollapseSetter(){
        if self.parent?.parent != nil {
            (self.parent?.parent as! projectStack).Stack.removeView(self.droppedDownSetter!.view)
            self.droppedDownSetter?.removeFromParent()
            self.droppedDownSetter = nil
            archive.layer?.backgroundColor = .init(gray: 1, alpha: 0)
            archive.wantsLayer  = false
            plan.layer?.backgroundColor = .init(gray: 1, alpha: 0)
            plan.wantsLayer = false
            work.layer?.backgroundColor = .init(gray: 1, alpha: 0)
            work.wantsLayer = false
        }
    }
    
   
}
