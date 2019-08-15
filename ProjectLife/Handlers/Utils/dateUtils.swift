//
//  dateGetter.swift
//  ProjectLife
//
//  Created by liumengda on 2019/8/15.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Foundation

class dateUtils {
    var month : String
    var year : Int
    var day : Int
    var weekDay : String
    var today = false
    var yesterday = false
    var tomorrow = false
    var theDayBeforeYesterday = false
    var theDayAfterTomorrow = false
    var baseString : String
    var date : Date
    
    init(date : Date, relativeIndicator : Int) {
        self.date = date
        let calendar = Calendar.current
        let wkd = calendar.component(.weekday, from: date)
        let m = calendar.component(.month, from: date)
        self.day = calendar.component(.day, from: date)
        self.year = calendar.component(.year, from: date)
        
        var M : String
        switch m {
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
        
        var WD : String
        
        switch wkd {
        case 1:
            WD = "Monday"
        case 2:
            WD = "Tuesday"
        case 3:
            WD = "Wednesday"
        case 4:
            WD = "Thursday"
        case 5:
            WD = "Friday"
        case 6:
            WD = "Saturday"
        case 7:
            WD = "Sunday"
        default:
            WD = ""
        }
        
        self.weekDay = WD
        self.month = M
        
        self.baseString = String(self.month) + " " + String(self.day) + ", " + String(self.year) + "(" + String(self.weekDay) + ")"
        
        
        switch relativeIndicator {
        case 0:
            today = true 
        case 1 :
            tomorrow = true
        case 2 :
            theDayAfterTomorrow = true
        case -1:
            yesterday = true
        case -2:
            theDayBeforeYesterday = true
        default:
             tomorrow = false
            //nothing true
        }
    }
    
    func forDayPage() -> String {
        var result : String
        result = self.baseString
        if self.today{
            result = result + " --> Today"
        } else if self.yesterday {
            result = result + " --> Yesterday"
        } else if self.theDayBeforeYesterday {
            result = result + " --> The Day Before Yesterday"
        } else if self.tomorrow {
            result = result + " --> Tommorrow"
        } else if self.theDayAfterTomorrow {
            result = result + " --> The Day After Tommorrow"
        }
        return result
    }
    
    func forProjectSet() -> String {
        var result : String
        result = self.baseString
        if self.today{
            result = "Today : " + result
        } else if self.yesterday {
            result = "Yesterday : " + result
        } else if self.theDayBeforeYesterday {
            result = "The Day Before Yesterday : " + result
        } else if self.tomorrow {
            result = "Tommrrow : " + result
        } else if self.theDayAfterTomorrow {
            result = "The Day After Tomorrow : " + result
        }
        return result
    }
    
    func getDay(addBy : Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: addBy, to: self.date)!
    }
}
