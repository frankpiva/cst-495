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
    
    
    override func awakeFromNib() {
        // print("TweetTableViewCell: awakeFromNib()")
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        // print("TweeTableViewCell: setSelected()")
        super.setSelected(selected, animated: animated)
    }

}
