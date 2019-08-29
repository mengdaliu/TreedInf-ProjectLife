//
//  Enter.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/16.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class Enter: NSViewController {
    
    static var instance : Enter?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        var time : String?
        if 3 <= hour && 11 >= hour {
            time = "Good Morning, "
            if hour == 8 {
                time = "Don't forget to grab breakfast, "
            } else if minute == 60 {
                time = "What a fresh morning, "
            }
        } else if 11 < hour && 17 >= hour {
            time = "Good Afternoon, "
            if hour == 12 {
                time = "It's lunch time, "
            }else if minute == 60 {
                time = "What a lovely afternoon, "
            }
        } else if 17 < hour && 23 >= hour {
            time = "Good Evening, "
            if hour == 18 {
                time = "I hope you enjoy your dinner, "
            } else if minute == 60 {
                time = "Look up at the stars, "
            }
        } else {
            time = "Good Night, "
            if hour == 24 || hour < 3 {
                time = "Sleep early, "
            }
        }
        
        let weekDay = calendar.component(.weekday, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let year = calendar.component(.year, from: date)
        
        var M : String?
        switch month {
        case 1 :
            M = "January"
        case 2:
            M = "Feburary"
        case 3:
            M = "March"
        case 4:
            M = "April"
        case 5:
            M = "May"
        case 6:
            M = "June"
        case 7:
            M = "July"
        case 8:
            M = "August"
        case 9:
            M = "September"
        case 10:
            M = "October"
        case 11:
            M = "November"
        case 12:
            M = "December"
        default:
            M =  ""
        }
        
        var WD : String?
        
        switch weekDay {
        case 2:
            WD = "Monday"
        case 3:
            WD = "Tuesday"
        case 4:
            WD = "Wednesday"
        case 5:
            WD = "Thursday"
        case 6:
            WD = "Friday"
        case 7:
            WD = "Saturday"
        case 1:
            WD = "Sunday"
        default:
            WD = ""
        }
        
        var today = WD! + ", "
        today = today + M! + " " + String(day)
        today = today + ", " + String(year)
        d.stringValue = today
        d.textColor = ColorGetter.getCurrentThemeColor()
        d.font = .labelFont(ofSize: 40)
        
    
        
        
        let nickName = (dalGlobal.userInfo?.nickname)! + "!"
        
        
        greetingLine.stringValue = time! + nickName
       
        
        greetingLine.font = .labelFont(ofSize: 65)
        let color = ColorGetter.getCurrentThemeColor()
        greetingLine.textColor = color
        
        
        sentence.font = .labelFont(ofSize: 30)
        sentence.textColor = color
        
        Enter.instance = self
    }
    
    @IBOutlet weak var greetingLine: NSTextFieldCell!
    
    @IBOutlet weak var d: NSTextFieldCell!
    @IBOutlet weak var sentence: NSTextField!
    
    override func viewDidAppear() {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                self.didAppearHelper()
            }
            sleep(60)
        }
    }
    
    func didAppearHelper(){
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        var time : String?
        if 3 <= hour && 11 >= hour {
            time = "Good Morning, "
        } else if 11 < hour && 17 >= hour {
            time = "Good Afternoon, "
        } else if 17 < hour && 23 >= hour {
            time = "Good Evening, "
        } else {
            time = "Good Night, "
        }
        
        let weekDay = calendar.component(.weekday, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let year = calendar.component(.year, from: date)
        
        var M : String?
        switch month {
        case 1 :
            M = "January"
        case 2:
            M = "Feburary"
        case 3:
            M = "March"
        case 4:
            M = "April"
        case 5:
            M = "May"
        case 6:
            M = "June"
        case 7:
            M = "July"
        case 8:
            M = "August"
        case 9:
            M = "September"
        case 10:
            M = "October"
        case 11:
            M = "November"
        case 12:
            M = "December"
        default:
            M =  ""
        }
        
        var WD : String?
        
        switch weekDay {
        case 2:
            WD = "Monday"
        case 3:
            WD = "Tuesday"
        case 4:
            WD = "Wednesday"
        case 5:
            WD = "Thursday"
        case 6:
            WD = "Friday"
        case 7:
            WD = "Saturday"
        case 1:
            WD = "Sunday"
        default:
            WD = ""
        }
        
        var today = WD! + ", "
        today = today + M! + " " + String(day)
        today = today + ", " + String(year)
        d.stringValue = today
        d.textColor = ColorGetter.getCurrentThemeColor()
        d.font = .labelFont(ofSize: 40)
        
        
        
        
        let nickName = (dalGlobal.userInfo?.nickname)! + "!"
        
        
        greetingLine.stringValue = time! + nickName
        
        
        greetingLine.font = .labelFont(ofSize: 65)
        let color = ColorGetter.getCurrentThemeColor()
        greetingLine.textColor = color
    }
    
    
    func changeGreetingLineColor(color: NSColor) {
        greetingLine.textColor = color
        d.textColor = color
        sentence.textColor = color
    }
    

    
    
}
