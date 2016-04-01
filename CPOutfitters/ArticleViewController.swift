//
//  ArticleViewController.swift
//  CPOutfitters
//
//  Created by Cory Thompson on 3/9/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import ChameleonFramework
import Parse
import ParseUI
import UIColor_Hex

protocol ArticleDelegate {
    func articleSaved(article: Article)
    func articleDeleted(article: Article)
}

let bgColorUnselected = UIColor(hue: 200/360, saturation: 0.40, brightness: 1.0, alpha: 1.0)
let bgColorSelected = UIColor(hue: 200/360, saturation: 1.0, brightness: 1.0, alpha: 1.0)

class ArticleViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var longOrShortSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var pictureImageView: PFImageView!
    @IBOutlet weak var averageColorImageView: UIImageView!
    @IBOutlet weak var casualButton: UIButton!
    @IBOutlet weak var workButton: UIButton!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var socialButton: UIButton!
    @IBOutlet weak var formalButton: UIButton!
    @IBOutlet weak var blkTieButton: UIButton!
    
    var delegate: ArticleDelegate?
    
    var libraryHasBeenViewed: Bool!
    var vc: UIImagePickerController!
    var occasionDictionary: [String:Bool] = ["Casual": false, "Work": false, "Date": false, "Social": false, "Formal": false, "Blk Tie": false]
    var buttonDictionary: [String:UIButton]!
    
    var article: Article! {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        libraryHasBeenViewed = false
        vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        buttonDictionary = ["Casual": casualButton, "Work": workButton, "Date": dateButton, "Social": socialButton, "Formal": formalButton, "Blk Tie": blkTieButton]
        
        /* set the occasion buttons bgcolor by iterating through the button dictionary */
        if article.occasion.count > 0 {
            for attire in article.occasion {
                if occasionDictionary[attire]! {
                    buttonDictionary[attire]!.backgroundColor = bgColorSelected
                } else {
                    buttonDictionary[attire]!.backgroundColor = bgColorUnselected
                }
            }
        } else {
            for (_,button) in buttonDictionary {
                button.backgroundColor = bgColorUnselected
            }
        }
        
        pictureImageView.file = article.mediaImage
        if article.short {
            longOrShortSegmentedControl.selectedSegmentIndex = 0
        } else {
            longOrShortSegmentedControl.selectedSegmentIndex = 1
        }
        
        averageColorImageView.backgroundColor = UIColor(CSS: article.primaryColor)
    }
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        pictureImageView.image = editedImage
        
        let newSize = CGSize(width: 1000, height: 750)
        if let image = pictureImageView.image {
            let resizedImage = resizeImage(image, newSize: newSize)
            article.mediaImage = Article.getPFFileFromImage(resizedImage)!
        }
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSave() {
        ParseClient.sharedInstance.saveArticle(article) { (success, error) in
            if success {
                self.delegate?.articleSaved(self.article)
                self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            }
            else {
                // notify user
                self.delegate?.articleSaved(self.article)
            }
        }
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onAnOccasionButton(sender: AnyObject) {
        let selected = sender as! UIButton
        print(selected.currentTitle)
        print(occasionDictionary[selected.currentTitle!])
        let selectedTitle = selected.currentTitle!
        let occassionSet = occasionDictionary[selectedTitle]!
        
        occasionDictionary[selectedTitle]! = !occassionSet
        if !occassionSet {
            selected.backgroundColor = bgColorSelected
            selected.tintColor = bgColorUnselected
            article.occasion.append(selectedTitle)
        } else {
            selected.backgroundColor = bgColorUnselected
            selected.tintColor = bgColorSelected
            if let index = article.occasion.indexOf(selectedTitle) {
                article.occasion.removeAtIndex(index)
            }
        }
    }
    
    @IBAction func onActionCamera(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            vc.sourceType = .Camera
            self.presentViewController(vc, animated: true, completion: nil)
        } else {
            print("ArticleViewController: Camera unavailable so we are using the photo library")
            vc.sourceType = .PhotoLibrary
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func onGetAverageColorFromPicture(sender: UITapGestureRecognizer) {
        let location = sender.locationInView(pictureImageView)
        print("ArticleViewController: Tapped your picture at location: \(location)")
        
        let newSize = CGSize(width: 50, height: 50)
        if let image = pictureImageView.image {
            let newImage = image.resize(pictureImageView.frame.size)
            let clip = CGRectMake(location.x - (newSize.width/2), location.y - (newSize.height/2), newSize.width, newSize.height)
            let imageClip = CGImageCreateWithImageInRect(newImage.CGImage, clip)
            
            averageColorImageView.image = UIImage(CGImage: imageClip!)
            
            article.swatchImage = Article.getPFFileFromImage(UIImage(CGImage: imageClip!))!
            let averageColor = UIColor(averageColorFromImage: UIImage(CGImage: imageClip!))
            article.primaryColor = averageColor.hexString()
            print("ArticleViewController: The color saved is \(article.primaryColor)")
            
        }
    }
    
    @IBAction func onSegmentedControllerChange(sender: AnyObject) {
        let segmentedController = sender as! UISegmentedControl
        article.short = (segmentedController.titleForSegmentAtIndex(segmentedController.selectedSegmentIndex) == "Short")
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        if article.favorite {
            article.favorite = false
        } else {
            article.favorite = true
        }
    }
    
    @IBAction func onDelete(sender: AnyObject) {
        ParseClient.sharedInstance.deleteArticle(article) { (success, error) in
            if success {
                self.delegate?.articleDeleted(self.article)
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
