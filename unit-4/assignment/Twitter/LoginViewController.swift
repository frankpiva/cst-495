//
//  LoginViewController.swift
//  Twitter
//
//  Created by admin on 2/16/20.
//  Copyright © 2020 Frank Piva. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        // print("LoginViewController.swift: viewDidAppear()")
        if (UserDefaults.standard.bool(forKey: "userLoggedIn") == true) {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }

    override func viewDidLoad() {
        // print("LoginViewController: viewDidLoad()")
        super.viewDidLoad()
    }

    @IBAction func loginButton(_ sender: Any) {
        // print("LoginViewController.swift: loginButton()")
        let url = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: url, success: {
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (error) in
            print("error authenticating \(error)")
        })
    }

}
