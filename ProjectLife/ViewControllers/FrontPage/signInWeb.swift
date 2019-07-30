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
    var request : URLRequest?
    var c = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.setFrameSize(NSSize.init(width: 1200, height: 900))

        let urlString = NSString(format: NSString.init(string : "https://www.facebook.com/v3.3/dialog/oauth?client_id=%@&redirect_uri=%@&response_type=token"), Facebook.AppId, "https://www.facebook.com/connect/login_success.html") as String
        let facebookUrl = URL(string: urlString)
        var facebookLoginRequest = URLRequest.init(url: facebookUrl!)
        self.request = facebookLoginRequest
        
        
        
        
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

    func disableAutocomplete(w : WKWebView) {
        let disableAutocompleteScript: String = """
        var textFields = document.getElementsByTagName('input');
        if (textFields) {
            var i;
            for( i = 0; i < textFields.length; i++) {
                var txtField = textFields[i];
                if(txtField) {
                    txtField.setAttribute('autocorrect', 'off');
                    txtField.setAttribute('autocapitalize','none');
                    txtField.setAttribute('autocomplete', "off");
                    txtField.setAttribute('spellcheck', 'false');
                   
                }
            }
        }
    """
        w.evaluateJavaScript(disableAutocompleteScript, completionHandler: {
            data, error in})
    }
    
    func disableAutofocus(w: WKWebView) {
        let disableAutoFocusScript : String = """
               var elelist = document.getElementsByTagName("input");
               for(var i = 0; i < elelist.length; i++){
                    elelist[i].blur();
               }
    """
        w.evaluateJavaScript(disableAutoFocusScript, completionHandler: {data, err in})
    }
    
    
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        c += 1
        if c == 3 {
            disableAutocomplete(w: signInWebView)
            disableAutofocus(w: signInWebView)
        }
        
        
        if let urlStr = navigationAction.request.url?.absoluteString {
            if navigationAction.navigationType.rawValue == 1 || c >= 6 {
                let components = urlStr.components(separatedBy: "#access_token=")
                if components.count >= 2 {
                    DispatchQueue.main.async {
                        let dataStore = WKWebsiteDataStore.default()
                        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
                            for record in records {
                                if record.displayName.contains("facebook") {
                                    dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: {})
                                }
                            }
                        }
                    }
                    let secondHalf = components[1]
                    let paramComponents = secondHalf.components(separatedBy: "&")
                    let token = paramComponents[0]
                    self.token = token
                    self.gotToken = true
                    let parent = self.parent as! SignIn
                    parent.handleCollapse()
                }
            } else if navigationAction.navigationType.rawValue != 1 {
                DispatchQueue.main.async {
                    let dataStore = WKWebsiteDataStore.default()
                    dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
                        for record in records {
                            if record.displayName.contains("facebook") {
                                dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: {})
                            }
                        }
                    }
                }
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

