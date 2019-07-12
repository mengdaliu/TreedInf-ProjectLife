//
//  FrontPagePhoto.swift
//  ProjectLife
//
//  Created by liumengda on 2019/7/9.
//  Copyright © 2019 Unprecedented. All rights reserved.
//

import Cocoa

class FrontPagePhoto: NSViewController {
    
    var urls : [String] = []
    var maxSize : NSSize = NSSize.init(width: 0, height: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        backgroundImage.imageScaling = .scaleNone
        //backgroundImage.animates = true
        backgroundImage.imageFrameStyle = .photo
        backgroundImage.alphaValue = CGFloat(0.25)
        //loadBackgroundImageFromURL(url: "https://source.unsplash.com/featured/random?orientation=landscape&size=full&query=nature")
        DispatchQueue.global(qos: .background).async {
            sleep(10)
            self.getResponseFromUnsplash()
            self.keepLoading()
        }
    }
    
    @IBOutlet weak var backgroundImage: NSImageView!
    @IBAction func quikAction(_ sender: Any) {
        keepLoading()
    }
    
    @objc func loadBackgroundImageFromURL(url : String) {
        print("working")
        backgroundImage.image = NSImage.init(contentsOf: URL(string: url)!)
    }
    
    func keepLoading() {
        sleep(5)
        for image in self.urls {
            
            performSelector(onMainThread: #selector(loadBackgroundImageFromURL(url:)), with: image, waitUntilDone: false)
            sleep(5)
        }
    }
    
    
    func getResponseFromUnsplash(){
        let API = UnsplashAPI.init()
        let APIKey =  API.APIKey
        //let Secret =  API.Secret
        let picSize = NSScreen.main?.frame.size
        let w = picSize?.width; let h = picSize?.height
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
                for photo in receivedData!{

                    let urls = photo["urls"] as! [String: String]
                    let raw = urls["raw"]
                    let full = NSString.init(format: "%@?fm=jpg&q=75&w=%f&h=%f&fit=crop", raw!, w!, h! - 55) as String
                    self.urls.append(full)
                }
                
            } else {
                
            }
        })
        fetchTask.resume()
    }
    
    func loadBackgroundImageFromCache() {
        
    }
    
    func updateCache() {
        
    }
}
