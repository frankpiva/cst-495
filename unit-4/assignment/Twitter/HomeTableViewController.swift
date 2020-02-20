//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by admin on 2/16/20.
//  Copyright © 2020 Frank Piva. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var tweets = [NSDictionary]()
    var tweetCount = Int()

    override func viewDidLoad() {
        print("HomeTableViewController: viewDidLoad()")
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        print("HomeTableViewController: viewDidAppear()")
        super.viewDidAppear(animated)
        self.loadTweets()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        let user = self.tweets[indexPath.row]["user"] as! NSDictionary
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        if let imageData = data {
            cell.imageView?.image = UIImage(data: imageData)
        }
        cell.tweetLabel.text = self.tweets[indexPath.row]["text"] as? String
        cell.usernameLabel.text = user["name"] as? String
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tweets.count
    }

    @IBAction func logoutButton(_ sender: Any) {
        // print("HomeTableViewController: logoutButton()")
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        self.dismiss(animated: true, completion: nil)
    }

    func loadTweets() {
        // print("HomeTableViewController: loadTweets()")
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let parameters = ["count": 10]
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: parameters, success: { (tweets: [NSDictionary]) in
            // print("TwitterAPICaller: success()")
            self.tweets.removeAll()
            for tweet in tweets {
                self.tweets.append(tweet)
            }
            self.tableView.reloadData()
        }, failure: { (Error) in
            print("TwitterAPICaller: error()")
            print("failed to get tweets")
        })
    }

}
