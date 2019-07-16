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
        var urlString = NSString(format: NSString.init(string : "https://www.facebook.com/v3.3/dialog/oauth?client_id=%@&redirect_uri=%@&state=%@&response_type=token"), Facebook.AppId, "https://www.facebook.com/connect/login_success.html","CPLASF") as String
        let facebookUrl = URL(string: urlString)

        print(urlString)
        print(facebookUrl)
        let facebookLoginRequest = URLRequest.init(url: facebookUrl!)
        let session = URLSession.init(configuration: .default)
        let fetchTask = session.dataTask(with : facebookLoginRequest, completionHandler: {
            response, data, error in
            print(error == nil)
            print(data)
            print(response)
            print(error)
        })
        fetchTask.resume()
        print("hello world")
    }

    static func SignInFromGoogle() {
        
    }
    
    static func SignInFromWechat() {
        
    }
    
    static func DownloadData() {
        //Register User in Database if not already registered
        //DownloadData if already registered
    }
    
    static func KeepUserSignedIn() {
        
    }
    
    static func LogOutCurrentUser() {
        //Delete Data
    }
    
}
