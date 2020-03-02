//
//  LoginViewController.swift
//  unit5
//
//  Created by administrator on 3/1/20.
//  Copyright © 2020 Frank Piva. All rights reserved.
//

import Parse
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        print("LoginViewController.swift: viewDidLoad()")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapSignInButton(_ sender: Any) {
        print("LoginViewController.swift: tapSignInButton()")
        let password = self.passwordTextField.text!
        let username = self.usernameTextField.text!
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if (user != nil) {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("LoginViewController.swift: \(error?.localizedDescription)")
            }
        }
    }

    @IBAction func tapSignUpButton(_ sender: Any) {
        print("LoginViewController.swift: tapSignUpButton()")
        let user = PFUser()
        user.password = self.passwordTextField.text
        user.username = self.usernameTextField.text
        user.signUpInBackground { (success, error) in
            if (success) {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("LoginViewController.swift: \(error?.localizedDescription)")
            }
        }
    }

}
