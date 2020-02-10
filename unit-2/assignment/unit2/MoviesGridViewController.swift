//
//  MoviesGridViewController.swift
//  unit2
//
//  Created by admin on 2/9/20.
//  Copyright © 2020 Frank Piva. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var movies = [[String: Any]]()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // print("MoviesGridViewController: collectionView()")
        return self.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // print("MoviesGridViewController: collectionView()")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let movie = movies[indexPath.item]
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        cell.posterImageView.af_setImage(withURL: posterUrl)
        return cell
    }

    override func viewDidLoad() {
        // print("MoviesGridViewController: viewDidLoad()")
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String: Any]]
                self.collectionView.reloadData()
            }
        }
        task.resume()
    }

}
