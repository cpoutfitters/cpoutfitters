//
//  CameraViewController.swift
//  CPOutfitters
//
//  Created by Cory Thompson on 3/9/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tagsTextField: UITextField!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var averageColorImageView: UIImageView!
    var libraryHasBeenViewed: Bool!
    var vc: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        libraryHasBeenViewed = false
        vc = UIImagePickerController()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if let _ = posterImageView.image {
            posterImageView.hidden = false
            averageColorImageView.hidden = false
            tagsTextField.hidden = false
        } else {
            averageColorImageView.hidden = true
            tagsTextField.hidden = true
            posterImageView.hidden = true
        }
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            // Do something with the images (based on your use case)
            posterImageView.image = editedImage
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            vc.sourceType = .Camera
            self.presentViewController(vc, animated: true, completion: nil)
        } else {
            print("camera not available")
        }
        
    }
    
    @IBAction func onLibraryButton(sender: AnyObject) {
        vc.sourceType = .PhotoLibrary
        self.presentViewController(vc, animated: true, completion: nil)
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
