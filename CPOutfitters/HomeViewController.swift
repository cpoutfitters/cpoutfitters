//
//  HomeViewController.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 08/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import ParseUI

class HomeViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        ParseClient.sharedInstance.fetchArticles(["key": "value"], completion: {(articles, error) -> () in
//            for article in articles! {
//                print(article.type)
//            }
//        })

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        let current_user = PFUser.currentUser()?.username
        if (current_user == nil) {
            let loginViewController = PFLogInViewController()
            loginViewController.delegate = self
            loginViewController.signUpController?.delegate = self
            loginViewController.emailAsUsername = true
            self.presentViewController(loginViewController, animated: true, completion: nil)
        } else {
            print("User \(current_user) has logged in!")
        }
    }
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
