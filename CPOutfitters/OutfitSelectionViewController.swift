//
//  OutfitSelectionViewController.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 03/04/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse
let kselectTopSegueIdentifier = "selectTop"
let kselectBottomSegueIdentifier = "selectBottom"
let kselectFootwearSegueIdentifier = "selectFootwear"

class OutfitSelectionViewController: UIViewController {

    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var footwearButton: UIButton!
    
    var attire: String = ""
    var articles: [[Article]] = [[],[],[]]
    
    var outfit: Outfit! {
        didSet {
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*
         API Call for getting an outfit
         ParseClient.sharedInstance.suggestOutfit(["attire":attire]) 
         */
        ParseClient.sharedInstance.fetchArticles(["type":"top", "attire":attire]) { (articleObjects:[Article]?, error: NSError?) in
            if let articleObjects = articleObjects {
                self.articles[0] = articleObjects
            } else {
                let errorString = error!.userInfo["error"] as? NSString
                print("Error message: \(errorString)")
            }
        }
        ParseClient.sharedInstance.fetchArticles(["type":"bottom", "attire":attire]) { (articleObjects:[Article]?, error: NSError?) in
            if let articleObjects = articleObjects {
                self.articles[1] = articleObjects
            } else {
                let errorString = error!.userInfo["error"] as? NSString
                print("Error message: \(errorString)")
            }
        }
        ParseClient.sharedInstance.fetchArticles(["type":"footwear", "attire":attire]) { (articleObjects:[Article]?, error: NSError?) in
            if let articleObjects = articleObjects {
                self.articles[2] = articleObjects
            } else {
                let errorString = error!.userInfo["error"] as? NSString
                print("Error message: \(errorString)")
            }
        }
    }

    @IBAction func onRecommendMe(sender: AnyObject) {
        
        let owner = PFUser.currentUser()!
        
        print("OutfitSelectionViewController: onRecommend Button click")
        
        ParseClient.sharedInstance.getRecommendedOutfit(["occasion": attire]) { (outfit:Outfit?, error:NSError?) in
            if let outfit = outfit {
                let topImage = outfit.components[0].mediaImage as PFFile
                topImage.getDataInBackgroundWithBlock({ (imageData:NSData?, error: NSError?) in
                    if let imageData = imageData {
                        let image = UIImage(data: imageData)
                        self.topButton.setImage(image, forState: .Normal)
                    }
                })
            } else {
                print("OutfitSelectionViewController: \(error?.localizedDescription)")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == kselectTopSegueIdentifier {
            let selectTopViewController = segue.destinationViewController as! ArticleSelectionViewController
            selectTopViewController.articles = articles[0]
        } else if segue.identifier == kselectBottomSegueIdentifier {
            let selectBottomViewController = segue.destinationViewController as! ArticleSelectionViewController
            selectBottomViewController.articles = articles[1]
        } else if segue.identifier == kselectFootwearSegueIdentifier {
            let selectFootwearViewController = segue.destinationViewController as! ArticleSelectionViewController
            selectFootwearViewController.articles = articles[2]
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
