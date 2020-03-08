//
//  FeedViewController.swift
//  unit5
//
//  Created by administrator on 3/1/20.
//  Copyright © 2020 Frank Piva. All rights reserved.
//

import AlamofireImage
import MessageInputBar
import Parse
import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MessageInputBarDelegate {

    @IBOutlet weak var feedTableView: UITableView!
    var commentBar = MessageInputBar()
    var posts = [PFObject]()
    var selectedPost: PFObject!
    var showCommentBar = false

    override var canBecomeFirstResponder: Bool {
        return showCommentBar
    }

    override var inputAccessoryView: UIView? {
        return commentBar
    }

    override func viewDidLoad() {
        // print("FeedViewController.swift: viewDidLoad()")
        super.viewDidLoad()
        self.commentBar.delegate = self
        self.commentBar.inputTextView.placeholder = "Add a comment..."
        self.commentBar.sendButton.title = "Post"
        self.feedTableView.dataSource = self
        self.feedTableView.delegate = self
        self.feedTableView.keyboardDismissMode = .interactive
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(hideKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        // print("FeedViewController.swift: viewDidAppear()")
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Posts")
        query.includeKeys(["author", "comments", "comments.author"])
        query.addDescendingOrder("createdAt")
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

    @objc func hideKeyboard(notification: Notification) {
        // print("FeedViewController.swift: hideKeyboard()")
        self.commentBar.inputTextView.text = nil
        self.showCommentBar = false
        becomeFirstResponder()
    }

    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        // print("FeedViewController.swift: messageInputBar()")
        // create the comment
        let comment = PFObject(className: "Comment")
        comment["author"] = PFUser.current()!
        comment["post"] = self.selectedPost
        comment["text"] = text
        self.selectedPost.add(comment, forKey: "comments")
        self.selectedPost.saveInBackground { (success, error) in
            if (success) {
                print("FeedViewController.swift: comment saved")
            } else {
                print("FeedViewController.swift: \(error?.localizedDescription)")
            }
        }
        self.feedTableView.reloadData()
        // clear and dismiss the comment bar
        self.commentBar.inputTextView.text = nil
        self.showCommentBar = false
        becomeFirstResponder()
        self.commentBar.inputTextView.resignFirstResponder()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // print("FeedViewController.swift: numberOfSections(tableView)")
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // print("FeedViewController.swift: tableView(cellForRowAt)")
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        if (indexPath.row == 0) {
            let cell = self.feedTableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! PostTableViewCell
            let imageFileObject = post["image"] as! PFFileObject
            let imageUrl = imageFileObject.url!
            let url = URL(string: imageUrl)!
            let user = post["author"] as! PFUser
            cell.authorLabel.text = user.username as! String
            cell.captionLabel.text = post["caption"] as! String
            cell.photoImageView.af_setImage(withURL: url)
            return cell
        } else if (indexPath.row <= comments.count) {
            let cell = self.feedTableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
            let comment = comments[indexPath.row - 1]
            let user = comment["author"] as? PFUser
            cell.authorLabel.text = user?.username!
            cell.commentLabel.text = comment["text"] as? String
            return cell
        } else {
            let cell = self.feedTableView.dequeueReusableCell(withIdentifier: "AddCommentTableViewCell")!
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print("FeedViewController.swift: tableView(didSelectRowAt)")
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        if (indexPath.row == comments.count + 1) {
            self.selectedPost = post
            self.showCommentBar = true
            becomeFirstResponder()
            self.commentBar.inputTextView.becomeFirstResponder()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print("FeedViewController.swift: tableView(numberOfRowsInSection)")
        let post = posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        return comments.count + 2
    }

    @IBAction func tapLogoutButton(_ sender: Any) {
        // print("FeedViewController.swift: tapLogoutButton()")
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        // let delegate = UIApplication.shared.delegate as! SceneDelegate
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        delegate.window?.rootViewController = loginViewController
    }
}
