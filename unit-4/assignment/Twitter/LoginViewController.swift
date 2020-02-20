//
//  LoginViewController.swift
//  Twitter
//
//  Created by admin on 2/16/20.
//  Copyright © 2020 Frank Piva. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBAction func loginButton(_ sender: Any) {
        // print("LoginViewController: loginButton()")
        let url = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: url, success: {
            // print("TwitterAPICaller: success()");
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (Error) in
            print("TwitterAPICaller: failure()")
            print("login failed")
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // print("LoginViewController: viewDidAppear()")
        if (UserDefaults.standard.bool(forKey: "userLoggedIn") == true) {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
    
    override func viewDidLoad() {
        // print("LoginViewController: viewDidLoad()")
        super.viewDidLoad()
    }

}
