//
//  SignInHandler.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/15.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Foundation
import Cocoa


class SignInHandler {
    
    static func SignInFromFacebook(token : String) -> (existed : Bool, store: NSPersistentStore?){
        //userStore.setUserStore(id: "testUser")
        let url = URL(string: NSString.init(format: "https://graph.facebook.com/me?fields=id&access_token=%@", token) as String)
        
        var request = URLRequest.init(url: url!)
        request.httpMethod = "GET"
        let session = URLSession.init(configuration: .default)
        var id : String = ""
        let fetchTask = session.dataTask(with : request, completionHandler: {data, response, error in
            if error == nil {
                let receivedData = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String : String]
                id = receivedData!["id"]!
                print(id)
            } else {}
        })
        fetchTask.resume()
        var count = 0
        while id == "" {
            if count == 60 {
                return (false, nil)
            }
            sleep(1)
            count += 1
        }
        return userStore.getUserStore(id: id)
    }

    static func SignInFromGoogle() {
        
    }
    
    static func SignInFromWechat() {
        
    }
    
    
    static func LogOutCurrentUser() {
        //Delete Data
    }

}
