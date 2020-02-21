//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by admin on 2/16/20.
//  Copyright © 2020 Frank Piva. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favorited: Bool = false
    var retweeted: Bool = false
    var tweetId: Int = -1
    
    override func awakeFromNib() {
        // print("TweetTableViewCell.swift: awakeFromNib()")
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        // print("TweeTableViewCell.swift: setSelected()")
        super.setSelected(selected, animated: animated)
    }

    @IBAction func favoriteButton(_ sender: Any) {
        // print("TweetTableViewCell.swift: favoriteButton()")
        self.favorited = !self.favorited
        if (favorited) {
            TwitterAPICaller.client?.createFavorite(tweetId: self.tweetId, success: {
                self.setFavoriteButtonImage()
            }, failure: { (error) in
                print("error creating favorite \(error)")
            })
        } else {
            TwitterAPICaller.client?.destroyFavorite(tweetId: self.tweetId, success: {
                self.setFavoriteButtonImage()
            }, failure: { (error) in
                print("error destroying favorite \(error)")
            })
        }
    }

    @IBAction func retweetButton(_ sender: Any) {
        // print("TweetTableViewCell.swift: retweetButton()")
        self.retweeted = !self.retweeted
        if (retweeted) {
            TwitterAPICaller.client?.retweetStatus(tweetId: self.tweetId, success: {
                self.setRetweetButtonImage()
            }, failure: { (error) in
                print("error retweeting status \(error)")
            })
        } else {
            TwitterAPICaller.client?.unretweetStatus(tweetId: self.tweetId, success: {
                self.setRetweetButtonImage()
            }, failure: { (error) in
                print("error unretweeting status \(error)")
            })
        }
        self.setRetweetButtonImage()
    }

    func setFavoriteButtonImage() {
        // print("TweetTableViewCell.swift: setFavoriteButtonImage()")
        if (self.favorited) {
            self.favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            self.favoriteButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }

    func setRetweetButtonImage() {
        // print("TweetTableViewCell.swift: setFavoriteButtonImage()")
        if (self.retweeted) {
            self.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
        } else {
            self.retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
        }
    }

}
