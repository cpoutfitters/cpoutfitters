//
//  SignupViewController.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 19/04/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class SignupViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var genderControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func onSignup(sender: AnyObject) {
        let email = emailTextField.text
        let password = passwordTextField.text
        let fullname = fullnameTextField.text
        var genders = ["Male", "Female"]
        let userGender = genders[genderControl.selectedSegmentIndex]
        
        let finalEmail = email!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).lowercaseString
        // Validate the text fields
        if (email!.characters.count < 5) {
            let alert = UIAlertController(title: "Email Invalid", message: "Please enter a valid email address", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        } else if (password!.characters.count < 8) {
            let alert = UIAlertController(title: "Password too short", message: "Password must be at least 8 characters", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        } else {
            // Run a spinner to show a task in progress
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            let newUser = PFUser()
            
            newUser.username = finalEmail
            newUser.email = finalEmail
            newUser.password = password
            newUser["gender"] = userGender
            if fullname != "" {
                newUser["fullname"] = fullname
            }
            
            emailTextField.enabled = false
            passwordTextField.enabled = false
            
            // Sign up the user asynchronously
            newUser.signUpInBackgroundWithBlock({ (succeed, error: NSError?) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                self.emailTextField.enabled = true
                self.passwordTextField.enabled = true
                
                if let error = error {
                    var message: String
                    switch error.code {
                    case 125: message = "Please enter a valid email"
                    case 202, 203: message = "Email is already registered"
                    default: message = "Unknown error occurred"
                    }
                    let alert = UIAlertController(title: "Signup error", message: message, preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                    NSNotificationCenter.defaultCenter().postNotificationName(userDidLoginNotification, object: nil)
                }
            })
        }
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
