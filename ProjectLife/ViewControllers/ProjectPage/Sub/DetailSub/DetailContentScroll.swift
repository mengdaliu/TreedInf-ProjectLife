//
//  DescriptionScroll.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/2.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class DetailContentScroll: NSViewController {

    @IBOutlet weak var scroll: NSScrollView!
    var textField : NSTextView?
    var shiftPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let detailEnter = myTextView.init()
        detailEnter.backgroundColor = NSColor.init(cgColor: CGColor.init(gray: 0.9, alpha: 1))!
        scroll.backgroundColor = NSColor.init(cgColor: CGColor.init(gray: 0.9, alpha: 1))!
        detailEnter.font = .labelFont(ofSize: 15)
        detailEnter.isEditable = true
        //detailEnter.isGrammarCheckingEnabled = true
        //detailEnter.isContinuousSpellCheckingEnabled = true
        //detailEnter.isIncrementalSearchingEnabled = true
        //detailEnter.isAutomaticLinkDetectionEnabled = true
        //detailEnter.isAutomaticSpellingCorrectionEnabled = true
        detailEnter.isVerticallyResizable = true
        scroll.borderType = .noBorder
        NSLayoutConstraint.init(item: self.view, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 75).isActive = true
        scroll.documentView = detailEnter
        
        detailEnter.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: detailEnter, attribute: .leading, relatedBy: .equal, toItem: scroll, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: detailEnter, attribute: .trailing, relatedBy: .equal, toItem: scroll, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        self.textField = detailEnter
    }
    
    
    override func flagsChanged(with event: NSEvent) {
        if event.modifierFlags.contains(.shift) {
            self.shiftPressed = true
        } else {
            self.shiftPressed = false
        }
    }
    
    override func keyUp(with event: NSEvent) {
        if event.keyCode == 36 {
            if self.shiftPressed{
                print("there")
                (self.parent!.parent!.parent as! VerticalStack).addProjectItem()
            }
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

