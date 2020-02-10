//
//  MovieModalViewController.swift
//  unit2
//
//  Created by admin on 2/9/20.
//  Copyright © 2020 Frank Piva. All rights reserved.
//

import UIKit
import WebKit

class MovieModalViewController: UIViewController, WKUIDelegate {

    var movieId: Int = 0
    var videos: [[String: Any?]] = []
    var webView: WKWebView!
    
    override func loadView() {
        // print("MovieModalViewController: loadView()")
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        // print("MovieModalViewController: viewDidLoad()")
        super.viewDidLoad()
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(self.movieId)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.videos = dataDictionary["results"] as! [[String: Any]]
                let video = self.videos[0]
                let videoKey = video["key"] as! String
                let videoUrl = URL(string: "https://www.youtube.com/watch?v=\(videoKey)")
                let videoRequest = URLRequest(url: videoUrl!)
                self.webView.load(videoRequest)
            }
        }
        task.resume()
    }

}
