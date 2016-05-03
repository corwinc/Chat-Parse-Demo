//
//  LoginViewController.swift
//  Chat Parse Demo
//
//  Created by Corwin Crownover on 3/18/16.
//  Copyright © 2016 Corwin Crownover. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    // OUTLETS
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    
    
    // VIEW DID LOAD

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // FUNCTIONS
    @IBAction func onSignUp(sender: AnyObject) {
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                print("You succeeded!")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                print("Error: \(error)")
            }
        }
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password:passwordField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                print("Error: \(error)")
            }
        }
    }
    
    
    

}
