//
//  ProfileViewController.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 19/04/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userhandleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var articleCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        ParseClient.sharedInstance.getUser(["owner": PFUser.currentUser()!]) { (user: PFUser?, error:NSError?) in
            let userName = user?.username!.characters.split("@").map(String.init)
            self.userhandleLabel.text = userName![0]
            self.bioLabel.text = user!["bio"] as! String
            self.nameLabel.text = user!["fullname"] as! String
            if user!["profilePicture"] != nil {
                let imageFile = user!["profilePicture"] as! PFFile
                imageFile.getDataInBackgroundWithBlock {
                    (imageData: NSData?, error: NSError?) -> Void in
                    if let imageData = imageData {
                        self.userProfileImageView.image = UIImage(data:imageData)
                        self.userProfileImageView.layer.cornerRadius = self.userProfileImageView.frame.size.width / 2
                        self.userProfileImageView.clipsToBounds = true
                    }
                }
            }
        }
        ParseClient.sharedInstance.countArticles(["owner": PFUser.currentUser()!]) { (count:Int32?, error:NSError?) in
            var countFabrics: String = "0 Fabriqs"
            if count! == 1 {
                countFabrics = "\(count!) Fabriq"
            } else {
                countFabrics = "\(count!) Fabriqs"
            }
            self.articleCount.text = countFabrics
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        userProfileImageView.image = editedImage
        
        let newSize = CGSize(width: 500, height: 500)
        if let image = userProfileImageView.image {
            let resizedImage = resizeImage(image, newSize: newSize)
            
            self.userProfileImageView.image = resizedImage
            self.userProfileImageView.layer.cornerRadius = self.userProfileImageView.frame.size.width / 2
            self.userProfileImageView.clipsToBounds = true


            let user = PFUser.currentUser()
            user!["profilePicture"] = Article.getPFFileFromImage(resizedImage)
            user!.saveInBackground()
         }
        
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
