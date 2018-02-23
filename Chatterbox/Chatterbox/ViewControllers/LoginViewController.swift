//
//  LoginViewController.swift
//  Chatterbox
//
//  Created by Manik Narang on 2/21/18.
//  Copyright © 2018 Manik Narang. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func signupButton(_ sender: Any) {
        signup()

        self.performSegue(withIdentifier: "loginSegue", sender: nil)
    }

    @IBAction func loginButton(_ sender: Any) {
        login()

        self.performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
    func signup() {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text

        if ((usernameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!) {
            
            let alertController = UIAlertController(title: "Sign up Failed", message: "Username and Password Required",
                                                    preferredStyle: .alert)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
            }
        }
    }

    func login() {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        if (username.isEmpty || password.isEmpty) {
            
            let alertController = UIAlertController(title: "Login Failed", message: "Username and Password Required",
                                                    preferredStyle: .alert)

            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }

            // add the OK action to the alert controller
            alertController.addAction(OKAction)

            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }

        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

