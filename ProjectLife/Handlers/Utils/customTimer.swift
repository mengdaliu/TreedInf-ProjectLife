//
//  customTimer.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/30.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Foundation

class customTimer : NSObject {
    var timing = false
    var seconds : UInt32?
    var useconds : UInt32?
    var endHandler : () -> ()
    
    init(seconds : UInt32?, useconds: UInt32?, completionHandler : @escaping () -> ()) {
        self.seconds = seconds
        self.useconds  = useconds
        self.endHandler = completionHandler
    }


    func start() {
        self.timing = true
        sleep(self.seconds!)
        DispatchQueue.main.sync{
            self.end()
        }
        
    }
    
    func Ustart() {
        self.timing = true
        usleep(self.useconds!)
        DispatchQueue.main.sync{
            self.end()
        }
    }
    
    func end() {
        if self.timing == true {
            self.endHandler()
        }
        
    }
    
    func stop() {
        self.timing = false
    }
}
