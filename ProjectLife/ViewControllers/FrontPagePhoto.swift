//
//  FrontPagePhoto.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/9.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa
import Network

class FrontPagePhoto: NSViewController {
    
    var urls : [String] = []
    let picSize = NSScreen.main?.frame.size
    
    let monitor = NWPathMonitor()
    var ImageQueue = DispatchQueue.global(qos: .background)
    var w : CGFloat?
    var h : CGFloat?
    var transition = CATransition.init()
    @IBOutlet weak var greetingLine: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        backgroundImage.imageScaling = .scaleNone
        backgroundImage.animates = true
        backgroundImage.imageFrameStyle = .photo
        backgroundImage.alphaValue = CGFloat(0.25)
        self.w = self.picSize?.width
        self.h = self.picSize?.height
        self.transition.duration = 5
        self.transition.type = .fade
        self.transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        backgroundImage.wantsLayer = true
        backgroundImage.layer?.add(transition, forKey: nil)
        backgroundImage.image = NSImage.init(contentsOf: URL( string: NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", "https://images.unsplash.com/photo-1524260855046-f743b3cdad07?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9", self.w!, self.h! - 55) as String)!)
        monitor.pathUpdateHandler = statusChangeHandler
        monitor.start(queue : self.ImageQueue)
        greetingLine.font = .labelFont(ofSize: CGFloat(60))
        greetingLine.stringValue = "Good afternoon, Mengda!"
        greetingLine.textColor = ThemeColor.black
    }
    
    @IBOutlet weak var backgroundImage: NSImageView!
    
    
    func statusChangeHandler(path: NWPath) {
        if path.status == .satisfied {
            monitor.queue?.async {
                self.getResponseFromUnsplash()
                self.keepLoading()
            }
        }
    }
    
    @objc func loadBackgroundImageFromURL(url : String) {
        backgroundImage.layer?.add(self.transition, forKey: nil)
        backgroundImage.image = NSImage.init(contentsOf: URL(string : url)!)
    }
    
    func keepLoading() {
        sleep(10)
        while true {
            for image in self.urls {
                performSelector(onMainThread: #selector(loadBackgroundImageFromURL(url:)), with: image, waitUntilDone: false)
                sleep(300)
            }
            getResponseFromUnsplash()
            sleep(10)
        }
    }
    
    
    func getResponseFromUnsplash(){
        let API = UnsplashAPI.init()
        let APIKey =  API.APIKey
        //let Secret =  API.Secret
        
        
        let url = URL(string:  "https://api.unsplash.com/photos/random?featured&count=30&orientation=landscape&query=nature")!
        var request : URLRequest = URLRequest.init(url: url)
        request.allHTTPHeaderFields = [
            "Authorization" : "Client-ID " + APIKey,
        ]
        request.httpMethod = "GET"
        let session = URLSession.init(configuration: .default)
        let fetchTask = session.dataTask(with : request, completionHandler: {data, response, error in
            if error == nil {
                let receivedData = try? JSONSerialization.jsonObject(with: data!, options: []) as? [[String : Any]]
                var URLs : [String] = []
                for photo in receivedData!{
                    let urls = photo["urls"] as! [String: String]
                    let raw = urls["raw"]
                    let sizedRaw = NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", raw!, self.w!, self.h! - 55) as String
                    URLs.append(sizedRaw)

                }
                if  URLs.count >= 25 {
                    self.urls = URLs
                }
            } else {}
        })
        fetchTask.resume()
    }
}
