//
//  HomeViewController.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 08/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import ParseUI

class HomeViewController: UIViewController, PFLogInViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print(PFUser.currentUser()?.username)
        
        if PFUser.currentUser() == nil {
            if (PFUser.currentUser()?.username == nil) {
                let loginViewController = PFLogInViewController()
                loginViewController.delegate = self
                self.presentViewController(loginViewController, animated: false, completion: nil)
            } else {
                print("User not logged in!")
            }
        } else {
            presentLoggedInAlert()
        }
        
    }
    
    func presentLoggedInAlert() {
        let alertController = UIAlertController(title: "You're logged in", message: "Welcome!", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        presentLoggedInAlert()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
