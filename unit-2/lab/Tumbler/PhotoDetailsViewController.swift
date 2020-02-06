//
//  PhotoDetailsViewController.swift
//  Tumbler2
//
//  Created by administrator on 2/5/20.
//  Copyright © 2020 Justin Betts. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    var photoUrl = ""
    @IBOutlet weak var photoDetailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad()")
        let newUrl = URL(string: self.photoUrl)
        self.photoDetailImageView.af_setImage(withURL: newUrl!)
    }

}
