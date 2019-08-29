//
//  ViewController.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/2.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var projectLifeTitle: NSTextField!
    @IBOutlet weak var Logout: HoverButton!
    @IBOutlet weak var Lock: HoverButton!
    
    var selected : HoverButton?
    
    static var instance : ViewController?
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        mainView.boxType = .custom
        mainView.alphaValue = 1
        mainView.borderType = .noBorder
        mainView.wantsLayer = true
        mainView.layer?.backgroundColor = CGColor.init(red: CGFloat(0.9), green: CGFloat(0.9), blue: CGFloat(0.9), alpha: CGFloat(1))
        
        
        let photoController = FrontPagePhoto.init(nibName: "FrontPagePhoto", bundle: nil)
        self.addChild(photoController)
        mainView.contentView = photoController.view
        
       
        Logout.setText(str: "Log Out", color: .lightGray)
        Logout.isBordered = true
        Logout.showsBorderOnlyWhileMouseInside = true
        Logout.bezelStyle = .regularSquare
        if UserDefaults.standard.value(forKey: "UserLoggedIn") == nil {
            Logout.isEnabled = false
        } else {
            Logout.isEnabled = true
        }
        self.view.bringSubviewToFront(Logout)
        
        Lock.setText(str: "Lock", color: .lightGray)
        Lock.isBordered = true
        Lock.showsBorderOnlyWhileMouseInside = true
        Lock.bezelStyle = .regularSquare
        if UserDefaults.standard.value(forKey: "UserLoggedIn") == nil {
            Lock.isEnabled = false
        } else {
            Lock.isEnabled = true
        }
        
        Project.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: Project, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 90).isActive = true
        Days.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.init(item: Days, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 90).isActive = true
        
        
        
        var color = ColorGetter.getCurrentThemeColor()
        if color == ThemeColor.white {
            color = ThemeColor.black
        }
        
        Project.setText(str: "Projects", color: ThemeColor.white)
        Days.setText(str: "Days", color: ThemeColor.white)
        
        trivial.setText(str: "Trivial", color: color)
        Project.font = .labelFont(ofSize: 15)
        Days.font = .labelFont(ofSize: 15)
        Project.wantsLayer = true
        Project.layer?.backgroundColor = color.cgColor
        Project.isBordered = false
        //Project.wantsLayer = false
       
        Days.wantsLayer = true
        Days.layer?.backgroundColor = color.cgColor
        Days.showsBorderOnlyWhileMouseInside = true
        Days.isBordered = false
        //Days.wantsLayer = false
        trivial.wantsLayer = true
        trivial.layer?.backgroundColor = color.cgColor
        trivial.isBordered = false
        trivial.font = .labelFont(ofSize: 15)
        
        ViewController.instance = self
        
        if UserDefaults.standard.value(forKey: "UserLoggedIn") == nil {
            Project.isEnabled = false
            Days.isEnabled = false
        }
        
        
    }

    @IBOutlet weak var Days: HoverButton!

    @IBOutlet weak var mainView: NSBox!
    
    @IBAction func LogOut(_ sender: Any) {
        SignInHandler.LogOutCurrentUser()
        Unselect()
        DeactivateAll()
    }
    
    
    @IBAction func selectProject(_ sender: HoverButton) {
        self.dismiss(FrontPagePhoto.instance)
        FrontPagePhoto.instance = nil
        var wall : backgroundWall
        if backgroundWall.instance != nil {
            
            self.children.remove(at: 0)
            wall = backgroundWall.instance!
            mainView.contentView = wall.view
            self.addChild(wall)
        } else {
            //self.dismiss(self.children[0])
            
            self.children.remove(at: 0)
            wall = backgroundWall.init(nibName: "backgroundWall", bundle: nil)
            mainView.contentView = wall.view
            self.addChild(wall)
        }
       
        wall.handleSelectProjects()
        var color = ColorGetter.getCurrentThemeColor()
        if color == ThemeColor.white {
            color = ThemeColor.black
        }
        Project.layer = nil
        Days.wantsLayer = true
        Days.layer?.backgroundColor = color.cgColor
        Days.setText(str: "Days", color: ThemeColor.white)
        Project.setText(str: "Projects", color: color)
        self.selected = sender
    }
    
    @IBAction func selectDays(_ sender: HoverButton) {
        self.dismiss(FrontPagePhoto.instance)
        FrontPagePhoto.instance = nil
        var wall : backgroundWall
        if backgroundWall.instance != nil {
            self.children.remove(at: 0)
            wall = backgroundWall.instance!
            mainView.contentView = wall.view
            self.addChild(wall)
        } else {
            //self.dismiss(self.children[0])
            self.children.remove(at: 0)
            wall = backgroundWall.init(nibName: "backgroundWall", bundle: nil)
            mainView.contentView = wall.view
            self.addChild(wall)
        }
    
        wall.handleSelectDays()
        var color = ColorGetter.getCurrentThemeColor()
        if color == ThemeColor.white {
            color = ThemeColor.black
        }
        Days.layer = nil
        Project.wantsLayer = true
        Project.layer?.backgroundColor = color.cgColor
        
        Days.setText(str: "Days", color: color)
        Project.setText(str: "Projects", color: ThemeColor.white)
     
        self.selected = sender
    }
    @IBOutlet weak var Project: HoverButton!
    @IBOutlet weak var trivial: HoverButton!
    
    func changeTabColor(color : NSColor) {
        tabHelper(tab: Project, color: color, text: "Projects")
        tabHelper(tab: Days, color: color, text: "Days")
        trivial.setText(str: "t", color: color)
        trivial.layer?.backgroundColor = color.cgColor
    }
    
    func tabHelper(tab : HoverButton, color : NSColor, text : String) {
        if self.selected == tab {
            if color == ThemeColor.white {
                tab.setText(str: text, color: ThemeColor.black)
            } else {
                tab.setText(str: text, color: color)
            }
        } else {
            if color == ThemeColor.white{
                tab.setText(str: text, color: ThemeColor.black)
            } else {
                 tab.setText(str: text, color: ThemeColor.white)
            }
            tab.layer?.backgroundColor = color.cgColor
        }
       
    }
    
    func Unselect() {
        self.selected = nil
        var color = ColorGetter.getCurrentThemeColor()
        if color == ThemeColor.white {
            color = ThemeColor.black
        }
        changeTabColor(color: color)
    }
    
    func DeactivateAll() {
        Project.isEnabled = false
        Days.isEnabled = false
    }
    
    func ActivateAll() {
        Project.isEnabled = true
        Days.isEnabled = true
    }
    
    
    @objc func lock() {
        if backgroundWall.instance != nil {
            self.children.remove(at: 0)
            let frontPage = FrontPagePhoto.init(nibName: "FrontPagePhoto", bundle: nil)
            self.mainView.contentView = frontPage.view
            self.addChild(frontPage)
        } else {
        }
        Unselect()
    }
    
    
    @IBAction func IBLock(_ sender: HoverButton) {
        self.lock()
    }
    
}

