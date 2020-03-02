//
//  PostTableViewCell.swift
//  unit5
//
//  Created by administrator on 3/1/20.
//  Copyright © 2020 Frank Piva. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        // print("PostTableViewCell.swift: awakeFromNib()")
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        // print("PostTableViewCell.swift: setSelected()")
        super.setSelected(selected, animated: animated)
    }

}
