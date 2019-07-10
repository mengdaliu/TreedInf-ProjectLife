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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        backgroundImage.imageScaling = .scaleProportionallyUpOrDown
        //backgroundImage.animates = true
        backgroundImage.imageFrameStyle = .photo
        backgroundImage.alphaValue = CGFloat(0.25)
        //loadBackgroundImageFromURL(url: "https://source.unsplash.com/featured/random?orientation=landscape&size=full&query=nature")
        getResponseFromUnsplash()
        DispatchQueue.global(qos: .background).async {
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
            
            performSelector(onMainThread: #selector(loadBackgroundImageFromURL(url:)), with: image, waitUntilDone: true)
            sleep(5)
        }
    }
    
    
    func getResponseFromUnsplash(){
        let API = UnsplashAPI.init()
        let APIKey =  API.APIKey
        //let Secret =  API.Secret
        let url = URL(string: "https://api.unsplash.com/photos/random?featured&count=30&orientation=landscape&query=nature")!
        var request : URLRequest = URLRequest.init(url: url)
        request.allHTTPHeaderFields = [
            "Authorization" : "Client-ID " + APIKey,
        ]
        request.httpMethod = "GET"
        let session = URLSession.init(configuration: .default)
        var URLs : [String] = []
        let fetchTask = session.dataTask(with : request, completionHandler: {data, response, error in
            if error == nil {
                print("no error")
                let receivedData = try? JSONSerialization.jsonObject(with: data!, options: []) as? [[String : Any]]
                for photo in receivedData!{
                    print("are you fucking working")
                    let urls = photo["urls"] as! [String: String]
                    let full = urls["full"]
                    self.urls.append(full!)
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
