//
//  FeedViewController.swift
//  unit5
//
//  Created by administrator on 3/1/20.
//  Copyright © 2020 Frank Piva. All rights reserved.
//

import AlamofireImage
import Parse
import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var feedTableView: UITableView!
    var posts = [PFObject]()

    override func viewDidLoad() {
        print("FeedViewController.swift: viewDidLoad()")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.feedTableView.dataSource = self
        self.feedTableView.delegate = self
        self.feedTableView.rowHeight = 350
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("FeedViewController.swift: viewDidAppear()")
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.addDescendingOrder("createdhttp://g.recordit.co/UpNNT7QM6l.gifAt")
        query.limit = 20
        query.findObjectsInBackground { (posts, error) in
            if (posts != nil) {
                self.posts = posts!
                self.feedTableView.reloadData()
            } else {
                print("FeedViewController.swift: \(error?.localizedDescription)")
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print("FeedViewController.swift: tableView()")
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // print("FeedViewController.swift: tableView()")
        let cell = self.feedTableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! PostTableViewCell
        let post = posts[indexPath.row]
        let imageFileObject = post["image"] as! PFFileObject
        let imageUrl = imageFileObject.url!
        let url = URL(string: imageUrl)!
        let user = post["author"] as! PFUser
        cell.authorLabel.text = user.username as! String
        cell.captionLabel.text = post["caption"] as! String
        cell.photoImageView.af_setImage(withURL: url)
        return cell
    }
}
