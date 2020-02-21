//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by admin on 2/16/20.
//  Copyright © 2020 Frank Piva. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var tweetCount = Int()
    var tweets = [NSDictionary]()

    override func viewDidLoad() {
        // print("HomeTableViewController.swift: viewDidLoad()")
        super.viewDidLoad()
        self.tableView.rowHeight = UITableView.automaticDimension
    }

    override func viewDidAppear(_ animated: Bool) {
        // print("HomeTableViewController.swift: viewDidAppear()")
        super.viewDidAppear(animated)
        self.loadTweets()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // print("HomeTableViewController.swift: numberOfSections()")
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // print("HomeTableViewController.swift: tableView()")
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        let user = self.tweets[indexPath.row]["user"] as! NSDictionary
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        if let imageData = data {
            cell.imageView?.image = UIImage(data: imageData)
        }
        cell.favorited = self.tweets[indexPath.row]["favorited"] as! Bool
        cell.setFavoriteButtonImage()
        cell.retweeted = self.tweets[indexPath.row]["retweeted"] as! Bool
        cell.setRetweetButtonImage()
        cell.tweetId = self.tweets[indexPath.row]["id"] as! Int
        cell.tweetLabel.text = self.tweets[indexPath.row]["text"] as? String
        cell.usernameLabel.text = user["name"] as? String
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print("HomeTableViewController.swift: tableView()")
        // #warning Incomplete implementation, return the number of rows
        return self.tweets.count
    }

    @IBAction func logoutButton(_ sender: Any) {
        // print("HomeTableViewController.swift: logoutButton()")
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        self.dismiss(animated: true, completion: nil)
    }

    func loadTweets() {
        // print("HomeTableViewController.swift: loadTweets()")
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let parameters = ["count": 10]
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: parameters, success: { (tweets: [NSDictionary]) in
            self.tweets.removeAll()
            for tweet in tweets {
                self.tweets.append(tweet)
            }
            self.tableView.reloadData()
        }, failure: { (error) in
            print("error loading tweets \(error)")
        })
    }

}
