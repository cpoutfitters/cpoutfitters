//
//  CameraViewController.swift
//  CPOutfitters
//
//  Created by Cory Thompson on 3/9/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import ChameleonFramework

protocol ArticleDelegate {
    func editCanceled()
    
    func articleSaved(success:Bool, error:NSError?)
}

class ArticleViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var longOrShortSegmentedControl: UISegmentedControl!
    @IBOutlet weak var pictureImageView: UIImageView!

    @IBOutlet weak var averageColorImageView: UIImageView!
    
    var libraryHasBeenViewed: Bool!
    var vc: UIImagePickerController!
    
    var article: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        libraryHasBeenViewed = false
        vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            // Do something with the images (based on your use case)
            pictureImageView.image = editedImage
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onAnOccasionButton(sender: AnyObject) {
        let selected = sender as! UIButton
        print(selected.currentTitle)
    }

    @IBAction func onActionCamera(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            vc.sourceType = .Camera
            self.presentViewController(vc, animated: true, completion: nil)
        } else {
            print("camera unavailable so we are using the photo library")
            vc.sourceType = .PhotoLibrary
            self.presentViewController(vc, animated: true, completion: nil)            
        }
    }
    
    @IBAction func onGetAverageColorFromPicture(sender: UITapGestureRecognizer) {
        let location = sender.locationInView(pictureImageView)
        print("Tapped your picture at location: \(location)")

        let newSize = CGSize(width: 50, height: 50)
        if let image = pictureImageView.image {
            let newImage = image.resize(pictureImageView.frame.size)
            let clip = CGRectMake(location.x - (newSize.width/2), location.y - (newSize.height/2), newSize.width, newSize.height)
            let imageClip = CGImageCreateWithImageInRect(newImage.CGImage, clip)
            

            let viewAverageColor = true        // change this to view the image vs the average color
            
            if viewAverageColor {
                let averageColor = UIColor(averageColorFromImage: UIImage(CGImage: imageClip!))
                averageColorImageView.backgroundColor = averageColor
                print("The color saved is \(averageColor)")
            } else {
                averageColorImageView.image = UIImage(CGImage: imageClip!)
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
