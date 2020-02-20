//
//  TweetViewController.swift
//  Twitter
//
//  Created by admin on 2/17/20.
//  Copyright © 2020 Frank Piva. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        print("TweetViewController: viewDidLoad()")
        super.viewDidLoad()
        self.tweetTextView.becomeFirstResponder()
    }

    @IBAction func cancelButton(_ sender: Any) {
        print("TweetViewController: cancelButton()")
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func tweetButton(_ sender: Any) {
        print("TweetViewController: tweetButton()")
        if (!self.tweetTextView.text.isEmpty) {
            print("tweet is empty")
            TwitterAPICaller.client?.postTweet(tweetString: self.tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("error posting tweet: \(error)")
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }

}
