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
    
    static func SignInFromFacebook() {
        let urlString = NSString(format: NSString.init(string : "https://www.facebook.com/v3.3/dialog/oauth?client_id=%@&redirect_uri=%@&state=%@&response_type=token"), Facebook.AppId, "https://www.facebook.com/connect/login_success.html") as String
        let facebookUrl = URL(string: urlString)
        
       
        
        let facebookLoginRequest = URLRequest.init(url: facebookUrl!)
        let session = URLSession.init(configuration: .default)
        var gotToken = false
        var token : String?
        func createDataTask() -> URLSessionDataTask {
            return session.dataTask(with : facebookLoginRequest, completionHandler: {
                response, data, error in
                if error == nil {
                    let returnUrl = data?.url
                    let urlString = returnUrl?.absoluteString
                    let components = urlString?.components(separatedBy: "#access_token=")
                    if components!.count < 2 {
                        return
                    }
                    let secondHalf = components?[1]
                    let paramComponents = secondHalf?.components(separatedBy: "&")
                    token = paramComponents?[0]
                    gotToken = true
                } else {
                }
            })
        }
        
        var count = 0
        while true {
            if count == 1 {
                 NSWorkspace.shared.open(facebookUrl!)
            }
            if count == 120 {
                break
            }
            let fetchTask = createDataTask()
            if count != 0 {
                sleep(1)
            }
            fetchTask.resume()
            if !gotToken {
                count += 1
            }
        }
        
        if token != nil {
            //query facebook graph api to get user id
            //在AWS中查找fb_id
            //if not found, create user in AWS
            //跳转页面
                //if new user : what should I call you
                //if not, direct enter
        }
    }

    static func SignInFromGoogle() {
        
    }
    
    static func LogOutCurrentUser() {
        //Delete Data
    }
    
}
