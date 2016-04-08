//
//  PostViewController.swift
//  CPOutfitters
//
//  Created by Cory Thompson on 4/6/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostViewController: UIViewController {
    
    
    @IBOutlet weak var footwearImageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var postCaptionTextField: UITextField!

    var article: Article?
    var outfit: Outfit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let outfit = outfit {
            outfit.topComponent?.mediaImage.getDataInBackgroundWithBlock({ (topImage: NSData?, error: NSError?) in
                if error == nil {
                    self.topImageView.image = UIImage(data: topImage!)
                }
            })
            outfit.bottomComponent?.mediaImage.getDataInBackgroundWithBlock({ (bottomImage: NSData?, error: NSError?) in
                if error == nil {
                    self.bottomImageView.image = UIImage(data: bottomImage!)
                }
            })
            outfit.footwearComponent?.mediaImage.getDataInBackgroundWithBlock({ (footwearImage: NSData?, error: NSError?) in
                if error == nil {
                    self.footwearImageView.image = UIImage(data: footwearImage!)
                }
            })
        } else {
            article?.mediaImage.getDataInBackgroundWithBlock { (picture: NSData?, error: NSError?) in
                if error == nil {
                    self.topImageView.image = UIImage(data: picture!)
                    
                    /* hack: Needs to retrive an outfit so the other views will be different */
                    self.bottomImageView.image = UIImage(data: picture!)
                    self.footwearImageView.image = UIImage(data: picture!)
                }
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPostImage(sender: AnyObject) {
        Post.postUserImage(topImageView.image, withCaption: postCaptionTextField.text) { (success: Bool, error: NSError?) in
            if success {
                print("posted")
                self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }

    @IBAction func onCancel(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
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
