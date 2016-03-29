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
        
//        let article = Article()
//        
//        // Mockup for Article class object
//        article["owner"] = PFUser.currentUser()!
//        article["type"] = "shirt"
//        article["short"] = true
//        article["primary_color"] = "blue"
//        article["primary_color_categories"] = ["blue", "green"]
//        article["occasion"] = ["casual"]
//        article["favorite"] = false
//        article["shared_with"] = [PFUser.currentUser()!, PFUser.currentUser()!]
//        article["media_image"] = Article.getPFFileFromImage(UIImage(named: "event"))
//        article["last_worn"] = NSDate()
//        article["use_count"] = 1
//        
//        ParseClient.sharedInstance.saveArticle(article) { (success, error) in
//            if success == true {
//                print("Article Saved")
//            } else {
//                print(error?.localizedDescription)
//            }
//        }
//        
//        print("Home view controller")
//        ParseClient.sharedInstance.fetchArticles(["key": "value"], completion: {(articles, error) -> () in
//            print("Fetching articles: \(articles?.count)")
//            for article in articles! {
//                print("Sample type loaded: \(article.type)")
//            }
//        })
//        
//        ParseClient.sharedInstance.searchArticlesWithParams(["search":"blue casual shirt"]) { (articles: [Article]?, error: NSError?) in
//            print("Searched articles: \(articles?.count)")
//            for article in articles! {
//                print("Sample type loaded: \(article.type)")
//            }
//        }

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
        performSegueWithIdentifier("login", sender: self)
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
