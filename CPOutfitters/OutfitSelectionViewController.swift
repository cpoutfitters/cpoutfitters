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

class OutfitSelectionViewController: UIViewController, ArticleSelectDelegate {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var footwearButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var attire: String = ""
    var articles: [[Article]] = [[],[],[]]
    var isTopSelected: Bool = false
    var isBottomSelected: Bool = false
    var isFootwearSelected: Bool = false
    
    var outfit: Outfit!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*
         API Call for getting an outfit
         ParseClient.sharedInstance.suggestOutfit(["attire":attire]) 
         */
        ParseClient.sharedInstance.fetchArticles(["type":"top", "occasion":attire]) { (articleObjects:[Article]?, error: NSError?) in
            if let articleObjects = articleObjects {
                self.articles[0] = articleObjects
            } else {
                let errorString = error!.userInfo["error"] as? NSString
                print("Error message: \(errorString)")
            }
        }
        ParseClient.sharedInstance.fetchArticles(["type":"bottom", "occasion":attire]) { (articleObjects:[Article]?, error: NSError?) in
            if let articleObjects = articleObjects {
                self.articles[1] = articleObjects
            } else {
                let errorString = error!.userInfo["error"] as? NSString
                print("Error message: \(errorString)")
            }
        }
        ParseClient.sharedInstance.fetchArticles(["type":"footwear", "occasion":attire]) { (articleObjects:[Article]?, error: NSError?) in
            if let articleObjects = articleObjects {
                self.articles[2] = articleObjects
            } else {
                let errorString = error!.userInfo["error"] as? NSString
                print("Error message: \(errorString)")
            }
        }
        saveButton.enabled = false
        loadOutfit()
    }

    @IBAction func onRecommendMe(sender: AnyObject) {
                
        print("OutfitSelectionViewController: onRecommend Button click")
        
        ParseClient.sharedInstance.getRecommendedOutfit(["occasion": attire]) { (type: String, article: Article?, error:NSError?) in
            if let error = error {
                print("OutfitSelectionViewController: \(error.localizedDescription)")
            }
            else if let article = article {
                switch (type) {
                case "top":
                    self.outfit.topComponent = article
                    self.loadTop()
                case "bottom":
                    self.outfit.bottomComponent = article
                    self.loadBottom()
                default:
                    self.outfit.footwearComponent = article
                    self.loadFootwear()
                }
            } else {
                print("No \(type)s available for criteria")
            }
        }
    }
    
    func loadOutfit() {
        loadTop()
        loadBottom()
        loadFootwear()
        self.favoriteButton.selected = false
    }
    
    func loadTop() {
        if let topImage = outfit.topComponent?.mediaImage {
            topImage.getDataInBackgroundWithBlock({ (imageData:NSData?, error: NSError?) in
                if let imageData = imageData {
                    let image = UIImage(data: imageData)
                    self.topButton.setBackgroundImage(image, forState: .Normal)
                }
            })
        }
    }
    
    func loadBottom() {
        if let bottomImage = outfit.bottomComponent?.mediaImage {
            bottomImage.getDataInBackgroundWithBlock({ (imageData:NSData?, error: NSError?) in
                if let imageData = imageData {
                    let image = UIImage(data: imageData)
                    self.bottomButton.setBackgroundImage(image, forState: .Normal)
                }
            })
        }
    }
    
    func loadFootwear() {
        if let footwearImage = outfit.footwearComponent?.mediaImage {
            footwearImage.getDataInBackgroundWithBlock({ (imageData:NSData?, error: NSError?) in
                if let imageData = imageData {
                    let image = UIImage(data: imageData)
                    self.footwearButton.setBackgroundImage(image, forState: .Normal)
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var articleArray: [Article] = []
        
        if let articleSelectionViewController = segue.destinationViewController as? ArticleSelectionViewController {
            if segue.identifier == kselectTopSegueIdentifier {
                 articleArray = articles[0]
            } else if segue.identifier == kselectBottomSegueIdentifier {
                articleArray = articles[1]
            } else if segue.identifier == kselectFootwearSegueIdentifier {
                articleArray = articles[2]
            }
            articleSelectionViewController.articles = articleArray
            articleSelectionViewController.delegate = self
        }
        
    }
    
    func articleSelected(article: Article) {
        //Add component to outfit
        let image = article.mediaImage
        
        image.getDataInBackgroundWithBlock({ (imageData:NSData?, error: NSError?) in
            if let imageData = imageData {
                let articleImage = UIImage(data: imageData)
                //Get type of article 
                let articleType = article.type
                var articleIndex = -1
                var button: UIButton
                switch(articleType)
                {
                case "top": button = self.topButton; self.outfit.topComponent = article; self.isTopSelected = true
                case "bottom": button = self.bottomButton; self.outfit.bottomComponent = article; self.isBottomSelected = true
                default: button = self.footwearButton; self.outfit.footwearComponent = article; self.isFootwearSelected = true
                }
                button.setTitle("", forState: .Normal)
                button.setBackgroundImage(articleImage, forState: .Normal)
                
                if self.isTopSelected && self.isBottomSelected && self.isFootwearSelected {
                    self.saveButton.enabled = true
                }
            }
        })
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSave(sender: AnyObject) {
        ParseClient.sharedInstance.saveOutfit(outfit) { (success, error) in
            if success {
                self.dismissViewControllerAnimated(true, completion: nil)
                print("outfit saved")
            } else {
                print(error?.localizedDescription)
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
