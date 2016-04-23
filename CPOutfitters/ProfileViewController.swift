//
//  ProfileViewController.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 19/04/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var userhandleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var articleCount: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ParseClient.sharedInstance.getUser(["owner": PFUser.currentUser()!]) { (user: PFUser?, error:NSError?) in
            print(user)
            let userName = user?.username!.characters.split("@").map(String.init)
            self.userhandleLabel.text = userName![0]
            self.bioLabel.text = user!["bio"] as! String
            self.nameLabel.text = user!["fullname"] as! String
        }
        ParseClient.sharedInstance.countArticles(["owner": PFUser.currentUser()!]) { (count:Int32?, error:NSError?) in
            let countFabrics = "\(count!) Fabriqs"
            print(countFabrics)
            self.articleCount.text = countFabrics
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEdit(sender: AnyObject) {
        performSegueWithIdentifier("editScreen", sender: self)
    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error:NSError?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User logged out")
                NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
            }
        }
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
