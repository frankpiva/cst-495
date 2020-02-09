//
//  MoviesViewController.swift
//  unit1
//
//  Created by administrator on 2/2/20.
//  Copyright © 2020 Frank Piva. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var movies: [[String: Any]] = []

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare()")
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        let movieDetailsViewController = segue.destination as! MovieDetailsViewController
        movieDetailsViewController.movie = movie
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewDidLoad() {
        // print("viewDidLoad()")
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // this will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String: Any]]
                // print("done fetching movies, reloading table view")
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print("tableView()", movies.count)
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // print("tableView()", indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let movie = movies[indexPath.row]
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        let synopsis = movie["overview"] as! String
        let title = movie["title"] as! String
        cell.posterView.af_setImage(withURL: posterUrl)
        cell.synopsisLabel.text = synopsis
        cell.titleLabel.text = title
        return cell
    }
}
