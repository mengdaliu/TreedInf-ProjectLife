//
//  ProjectHierarchyViewController.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/7.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class ProjectHierarchyViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello world")
        // Do view setup here.
    }
    
    override func addSplitViewItem(_ splitViewItem: NSSplitViewItem) {

    }

    @IBOutlet weak var testStackView: NSStackView!
    
    func manipulateStackView() {
        testStackView.addArrangedSubview(NSView.init())
    }
    
    @IBAction func haha(_ sender: Any) {
        print(1)
    }
    
    @IBAction func reTest(_ sender: Any) {
        print(2)
    }
    @IBAction func test2(_ sender: Any) {
        print(3)
    }
    @IBAction func qiguia(_ sender: Any) {
        print(4)
    }
}
