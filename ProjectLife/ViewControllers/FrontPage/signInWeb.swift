//
//  signInWeb.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/17.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa
import WebKit

class signInWeb: NSViewController, WKNavigationDelegate {
    

    var token = ""
    var gotToken = false
    static var instance : signInWeb?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.setFrameSize(NSSize.init(width: 800, height: 600))

        let urlString = NSString(format: NSString.init(string : "https://www.facebook.com/v3.3/dialog/oauth?client_id=%@&redirect_uri=%@&response_type=token"), Facebook.AppId, "https://www.facebook.com/connect/login_success.html") as String
        let facebookUrl = URL(string: urlString)
        var facebookLoginRequest = URLRequest.init(url: facebookUrl!)
        
        
        HTTPCookieStorage.shared.removeCookies(since: .distantPast)
        facebookLoginRequest.httpShouldHandleCookies = false
        
        
        signInWebView.load(facebookLoginRequest)
        signInWebView.navigationDelegate = self
        
        let loadedColor = ColorGetter.getCurrentThemeColor()
        
        backButton.font = .labelFont(ofSize: 15)
        if loadedColor != ThemeColor.white {
            backButton.setText(str: "Back", color: loadedColor)
        } else {
            backButton.setText(str: "Back", color: .black)
        }
        
        signInWeb.instance = self
    }
    
    
    @IBOutlet weak var signInWebView: WKWebView!
    
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        HTTPCookieStorage.shared.removeCookies(since: .distantPast)
        if let urlStr = navigationAction.request.url?.absoluteString {
            let components = urlStr.components(separatedBy: "#access_token=")
            if components.count >= 2 {
                let secondHalf = components[1]
                let paramComponents = secondHalf.components(separatedBy: "&")
                let token = paramComponents[0]
                self.token = token
                gotToken = true
                let parent = self.parent as! SignIn
                parent.handleCollapse()
            } 
        }
        decisionHandler(.allow)
    }
    
    @IBAction func goBack(_ sender: HoverButton) {
        let parent = self.parent as! SignIn
        parent.handleCollapse()
    }
    
    
    @IBOutlet weak var backButton: HoverButton!
    func changeButtonColor(color : NSColor) {
        if color != ThemeColor.white {
            backButton.setText(str: "Back", color: color)
        } else {
            backButton.setText(str: "Back", color: .black)
        }
    }
}
