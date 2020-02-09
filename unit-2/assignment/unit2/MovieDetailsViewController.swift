//
//  MovieDetailsViewController.swift
//  unit2
//
//  Created by admin on 2/9/20.
//  Copyright © 2020 Frank Piva. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var movie: [String: Any]! = [:]

    override func viewDidLoad() {
        print("MovieDetailViewController: viewDidLoad()")
        super.viewDidLoad()
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)!
        self.backdropImageView.af_setImage(withURL: backdropUrl)
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w185" + posterPath)!
        self.posterImageView.af_setImage(withURL: posterUrl)
        self.titleLabel.text = movie["title"] as? String
        self.titleLabel.sizeToFit()
        self.synopsisLabel.text = movie["overview"] as? String
        self.synopsisLabel.sizeToFit()
    }

}
