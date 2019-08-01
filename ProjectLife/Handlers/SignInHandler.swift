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
    
    static func SignInFromFacebook(token : String){
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
            } else {}
        })
        fetchTask.resume()
        var count = 0
        while id == "" {
            if count == 60 {
            }
            sleep(1)
            count += 1
        }
        let userId = "fb_" + id
        UserDefaults.standard.set(userId, forKey: "UserLoggedIn")
        ViewController.instance!.Logout.isEnabled = true
        ViewController.instance!.Lock.isEnabled = true
        userInfo.setUserStore(id: userId)
        userInfo.setUserInfoObject(id: userId)
        
    }

    static func SignInFromGoogle() {
        
    }
    
    static func SignInFromWechat() {
        
    }
    
    
    static func LogOutCurrentUser() {
        UserDefaults.standard.set(nil, forKey: "UserLoggedIn")
        ViewController.instance!.Logout.isEnabled = false
        ViewController.instance!.Lock.isEnabled = false
        let photoBackground = FrontPagePhoto.init(nibName: "FrontPagePhoto", bundle: nil)
        ViewController.instance!.mainView.contentView = photoBackground.view
        print(ViewController.instance!.children[0])
        ViewController.instance!.removeChild(at: 0)
        ViewController.instance!.addChild(photoBackground)
    }

}
