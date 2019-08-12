//
//  edit.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/11.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class edit: NSViewController {
    @IBOutlet weak var search: NSSearchField!
    @IBOutlet weak var percentage: NSTextField!
    @IBOutlet weak var percentMark: NSTextField!
    @IBOutlet weak var comment: NSTextField!
    
    class testSearch {
        var name : String
        var age : Int
        init(name : String, age : Int) {
            self.name = name
            self.age = age
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = .init(gray: 0.9, alpha: 1)
        NSLayoutConstraint.init(item: percentage, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 30).isActive = true
    }
    
    @IBAction func enteredSearchTerm(_ sender: NSSearchField) {
    }
    
    func load(from plan : Plan) {
        
    }
    
    func load(from done : Done) {
        
    }
}
