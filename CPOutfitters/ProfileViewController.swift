//
//  ProfileViewController.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 19/04/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userhandleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var articleCount: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
//    var articlesTop: [Article]?
//    var articlesBottom: [Article]?
//    var articlesFootwear: [Article]?
    var articles: [[Article]] = [[],[],[]]

    var combinedArticles: [Article]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        ParseClient.sharedInstance.getUser(["owner": PFUser.currentUser()!]) { (user: PFUser?, error:NSError?) in
            //print(user)
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
        ParseClient.sharedInstance.fetchArticles(["type":"top"]) { (articleObjects:[Article]?, error: NSError?) in
            if let articleObjects = articleObjects {
                    self.articles[0] = articleObjects
            } else {
                let errorString = error!.userInfo["error"] as? NSString
                print("Error message: \(errorString)")
            }
        }
        ParseClient.sharedInstance.fetchArticles(["type":"bottom"]) { (articleObjects:[Article]?, error: NSError?) in
            if let articleObjects = articleObjects {
                self.articles[1] = articleObjects
            } else {
                let errorString = error!.userInfo["error"] as? NSString
                print("Error message: \(errorString)")
            }
        }
        ParseClient.sharedInstance.fetchArticles(["type":"footwear"]) { (articleObjects:[Article]?, error: NSError?) in
            if let articleObjects = articleObjects {
                self.articles[2] = articleObjects
            } else {
                let errorString = error!.userInfo["error"] as? NSString
                print("Error message: \(errorString)")
            }
        }
//        print(self.articlesBottom)
//        for article in articlesBottom! {
//            combinedArticles?.append(article)
//        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (articles[section].count > 0) ? articles[section].count : 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FabricViewCell", forIndexPath: indexPath) as! FabricViewCell
        
        cell.article = articles[indexPath.section][indexPath.row]
        
        return cell
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEdit(sender: AnyObject) {
        //performSegueWithIdentifier("editScreen", sender: self)
    }
    
    @IBAction func onCamera(sender: AnyObject) {
        //Library picker being loaded
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
         didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        userProfileImageView.image = editedImage
        
        let newSize = CGSize(width: 500, height: 500)
        if let image = userProfileImageView.image {
            let resizedImage = resizeImage(image, newSize: newSize)
            
            self.userProfileImageView.image = resizedImage
            self.userProfileImageView.layer.cornerRadius = self.userProfileImageView.frame.size.width / 2
            self.userProfileImageView.clipsToBounds = true
     

//            var currentUser = PFUser.currentUser()
//            currentUser!.refreshInBackgroundWithBlock { (object, error) -> Void in
//                currentUser!.fetchIfNeededInBackgroundWithBlock { (result, error) -> Void in
//                    currentUser!.objectForKey("profileImage") =  Article.getPFFileFromImage(resizedImage!)                    
//                }
//            }
        }
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
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
    
    func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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
