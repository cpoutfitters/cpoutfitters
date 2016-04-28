//
//  ProfileViewController.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 19/04/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var userhandleLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var articleCount: UILabel!
    @IBOutlet weak var genderControl: UISegmentedControl!
    
    var bioText: String = ""
    var nameText: String = ""
    var genders = ["Male", "Female"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bioTextView.userInteractionEnabled = true
        fullnameTextField.userInteractionEnabled = true
        
        bioTextView.delegate = self
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        let user = PFUser.currentUser()
        let userName = user?.username!.characters.split("@").map(String.init)
        self.userhandleLabel.text = "@\(userName![0])"
        if user!["bio"] != nil {
            self.bioTextView.text = user!["bio"] as! String
            self.bioText = user!["bio"] as! String
        }
        if user!["fullname"] != nil {
            self.fullnameTextField.text = user!["fullname"] as? String
            self.nameText = user!["fullname"] as! String
        }
        if user!["gender"] != nil {
            let gender = user!["gender"] as! String
            self.genderControl.selectedSegmentIndex = self.genders.indexOf(gender)!
        }
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
        
        ParseClient.sharedInstance.countArticles(["owner": PFUser.currentUser()!]) { (count:Int32?, error:NSError?) in
            var countFabrics: String = "0 Fabriqs in your wardrobe"
            if count! == 1 {
                countFabrics = "\(count!) Fabriq in your wardrobe"
            } else {
                countFabrics = "\(count!) Fabriqs in your wardrobe"
            }
            self.articleCount.text = countFabrics
        }
        if nameText != "" && bioText != "" {
            
        }
    }
    
//    func keyboardWillShow(notification: NSNotification) {
//        
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//            self.view.frame.origin.y -= keyboardSize.height
//        }
//        
//    }
//    
//    func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//            self.view.frame.origin.y += keyboardSize.height
//        }
//    }

    @IBAction func onValueChanged(sender: AnyObject) {
        let user = PFUser.currentUser()!
        user["gender"] = genders[genderControl.selectedSegmentIndex]
        user.saveInBackground()
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
        ParseClient.sharedInstance.logoutUser()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    @IBAction func onEditingEnd(sender: AnyObject) {
        let user = PFUser.currentUser()!
        user["fullname"] = fullnameTextField.text
        user.saveInBackground()
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
    
    func textViewDidChange(textView: UITextView) {
        let user = PFUser.currentUser()!
        user["bio"] = bioTextView.text
        user.saveInBackground()
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
