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

    @IBOutlet weak var saveButton: UIBarButtonItem!
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
        
        let owner = PFUser.currentUser()!
        
        print("OutfitSelectionViewController: onRecommend Button click")
        
        ParseClient.sharedInstance.getRecommendedOutfit(["occasion": attire]) { (outfit: Outfit?, error:NSError?) in
            if let outfit = outfit{
                self.outfit = outfit
                print(outfit.self)
                self.loadOutfit()
            } else {
                print("OutfitSelectionViewController: \(error?.localizedDescription)")
            }
        }
    }
    
    func loadOutfit() {
        if let topImage = outfit.topComponent?.mediaImage {
            topImage.getDataInBackgroundWithBlock({ (imageData:NSData?, error: NSError?) in
                if let imageData = imageData {
                    let image = UIImage(data: imageData)
                    self.topButton.setBackgroundImage(image, forState: .Normal)
                }
            })
        }
        if let bottomImage = outfit.bottomComponent?.mediaImage {
            bottomImage.getDataInBackgroundWithBlock({ (imageData:NSData?, error: NSError?) in
                if let imageData = imageData {
                    let image = UIImage(data: imageData)
                    self.bottomButton.setBackgroundImage(image, forState: .Normal)
                }
            })
        }
        if let footwearImage = outfit.footwearComponent?.mediaImage {
            footwearImage.getDataInBackgroundWithBlock({ (imageData:NSData?, error: NSError?) in
                if let imageData = imageData {
                    let image = UIImage(data: imageData)
                    self.footwearButton.setImage(image, forState: .Normal)
                }
            })
        }
        self.favoriteButton.selected = outfit.favorite
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
    
    @IBAction func onSave(sender: AnyObject) {
        ParseClient.sharedInstance.saveOutfit(outfit) { (success, error) in
            if success {
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
