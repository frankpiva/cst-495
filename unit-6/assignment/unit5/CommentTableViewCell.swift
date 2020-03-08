//
//  CommentTableViewCell.swift
//  unit5
//
//  Created by administrator on 3/7/20.
//  Copyright © 2020 Frank Piva. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!

    override func awakeFromNib() {
        // print("CommentTableViewCell: awakeFromNib()")
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        // print("CommentTableViewCall: setSelected()")
        super.setSelected(selected, animated: animated)
    }

}
