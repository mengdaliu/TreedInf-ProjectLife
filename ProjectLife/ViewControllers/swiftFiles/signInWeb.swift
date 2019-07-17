//
//  signInWeb.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/17.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa
import WebKit

class signInWeb: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.setFrameSize(NSSize.init(width: 800, height: 600))
        var urlString = NSString(format: NSString.init(string : "https://www.facebook.com/v3.3/dialog/oauth?client_id=%@&redirect_uri=%@&state=%@&response_type=token"), Facebook.AppId, "https://www.facebook.com/connect/login_success.html","CPLASF") as String
        let facebookUrl = URL(string: urlString)
        
        print(urlString)
        print(facebookUrl)
        let facebookLoginRequest = URLRequest.init(url: facebookUrl!)
        
        signInWebView.load(facebookLoginRequest)
    }
    
    
    @IBOutlet weak var signInWebView: WKWebView!
}
