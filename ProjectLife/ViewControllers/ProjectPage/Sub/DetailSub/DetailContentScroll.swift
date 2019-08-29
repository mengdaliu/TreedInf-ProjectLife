//
//  DescriptionScroll.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/2.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class DetailContentScroll: NSViewController, NSTextViewDelegate {

    @IBOutlet weak var scroll: NSScrollView!
    var textField : NSTextView?
    var expanded = false
    var shiftPressed = false
    var smallConstraint : NSLayoutConstraint!
    var largeConstraint : NSLayoutConstraint!
    var parentP : Project!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let detailEnter = myTextView.init()
        detailEnter.drawsBackground = true
        detailEnter.font = .labelFont(ofSize: 17)
        detailEnter.isEditable = true
        //detailEnter.isGrammarCheckingEnabled = true
        //detailEnter.isContinuousSpellCheckingEnabled = true
        //detailEnter.isIncrementalSearchingEnabled = true
        //detailEnter.isAutomaticLinkDetectionEnabled = true
        detailEnter.isAutomaticSpellingCorrectionEnabled = true
        detailEnter.isVerticallyResizable = true
        detailEnter.backgroundColor = NSColor.init(cgColor: CGColor.init(gray: 0.92, alpha: 0.5))!
        scroll.borderType = .noBorder
        scroll.drawsBackground  = false
        self.smallConstraint = NSLayoutConstraint.init(item: self.view, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 75)
        self.largeConstraint = NSLayoutConstraint.init(item: self.view, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: NSScreen.main!.frame.height - 350)
        if !self.largeConstraint.isActive {
            self.smallConstraint.isActive = true
        }
        scroll.documentView = detailEnter
        
        detailEnter.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: detailEnter, attribute: .leading, relatedBy: .equal, toItem: scroll, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: detailEnter, attribute: .trailing, relatedBy: .equal, toItem: scroll, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        self.textField = detailEnter
        detailEnter.delegate = self
        detailEditingGlobal.editingTextView = self
        
        
    }
    
    override func viewDidAppear() {
        parentP = (self.parent!.parent!.parent as! projectStack).p
    }
    
    
    override func flagsChanged(with event: NSEvent) {
        if event.modifierFlags.contains(.shift) {
            moveHelperGlobal.shiftPressed = true
            self.shiftPressed = true
        } else {
            moveHelperGlobal.shiftPressed = false
            self.shiftPressed = false
        }
    }
    
    override func keyUp(with event: NSEvent) {
        if event.keyCode == 36 {
            if self.shiftPressed && (self.parent!.parent!.parent as! projectStack).p != dalGlobal.projectLife {
                (self.parent!.parent!.parent!.parent as! VerticalStack).addProjectItem()
            }
        }
    }
    
    
    func textDidEndEditing(_ notification: Notification) {
        guard let textView = notification.object as? NSTextView else { return }
        let proj = (self.parent!.parent!.parent as! projectStack).p
        project.setOverview(for: proj!, overview: textView.string)
    }
    
    override func rightMouseDown(with event: NSEvent) {
        if !expanded {
            expand()
            if !(self.parent!.parent as! projectDetail).expanded {
                (self.parent!.parent as! projectDetail).expand()
            }
        } else {
            collapse()
        }
    }
    
    
    @objc override func expand(){
        expanded = true
        self.smallConstraint.isActive = false
        self.largeConstraint.isActive = true
        (self.parent!.parent as! projectDetail).expandedSectionDetails.append(self)
    }
    
    @objc override func collapse(){
        expanded = false
        self.largeConstraint.isActive = false
        self.smallConstraint.isActive = true
        var i = 0
        for item in (self.parent!.parent as! projectDetail).expandedSectionDetails {
            if item == self {
                (self.parent!.parent as! projectDetail).expandedSectionDetails.remove(at: i)
                break
            }
            i += 1
        }
    }
    
    
    @objc override func storeEditing() {
        let stringValue = self.textField?.string
        if stringValue != nil {
            do {
                try project.setOverview(for: self.parentP, overview: stringValue!)
            } catch {}
        }
    }
}

class myTextView : NSTextView {
    override func didChangeText() {
        self.setFrameSize(self.contentSize)
    }
}

extension NSTextView {
    
    var contentSize: CGSize {
        get {
            guard let layoutManager = layoutManager, let textContainer = textContainer else {
                return .zero
            }
            
            layoutManager.ensureLayout(for: textContainer)
            return layoutManager.usedRect(for: textContainer).size
        }
    }
}

extension NSViewController {
    @objc func storeEditing() {}
    @objc func expand(){}
    @objc func collapse(){}
}
