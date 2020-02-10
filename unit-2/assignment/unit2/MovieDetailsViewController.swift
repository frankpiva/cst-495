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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // print("MovieDetailViewController: prepare()")
        let movieModalViewController = segue.destination as! MovieModalViewController
        movieModalViewController.movieId = self.movie["id"] as! Int
    }
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        // print("MovieDetailViewController: didTap()")
        performSegue(withIdentifier: "movieModalSegue", sender: nil)
    }
    
    
    override func viewDidLoad() {
        // print("MovieDetailViewController: viewDidLoad()")
        super.viewDidLoad()
        let backdropPath = self.movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)!
        self.backdropImageView.af_setImage(withURL: backdropUrl)
        let posterPath = self.movie["poster_path"] as! String
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w185" + posterPath)!
        self.posterImageView.af_setImage(withURL: posterUrl)
        self.titleLabel.text = self.movie["title"] as? String
        self.titleLabel.sizeToFit()
        self.synopsisLabel.text = self.movie["overview"] as? String
        self.synopsisLabel.sizeToFit()
    }

}
