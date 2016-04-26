//
//  WardrobeViewController.swift
//  CPOutfitters
//
//  Created by Eric Gonzalez on 3/10/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

let cellHeight: CGFloat = 100.0
let kAddArticleSegueIdentifier = "addArticle"
let kEditArticleSegueIdentifier = "editArticle"
let kPostArticleSegueIdentifier = "sendPost"

let primaryColorKey = "primaryColorCategories"
let occasionKey = "occasion"
let typeKey = "type"

class WardrobeViewController: UIViewController, UISearchBarDelegate, ArticleDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var types = ["Tops", "Bottoms", "Footwear"]
    var expanded = [true, true, true]
    var articles: [[Article]] = [[],[],[]]
    var filteredArticles: [[Article]] = [[], [], []]
    var newArticleFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        ParseClient.sharedInstance.fetchArticles(["type":"top"]) { (articles, error) in
            if let articles = articles {
                self.articles[0] = articles
                self.filteredArticles[0] = articles
                self.collectionView.reloadSections(NSIndexSet(index:0))
            }
        }
        ParseClient.sharedInstance.fetchArticles(["type":"bottom"]) { (articles, error) in
            if let articles = articles {
                self.articles[1] = articles
                self.filteredArticles[1] = articles
                self.collectionView.reloadSections(NSIndexSet(index:1))
            }
        }
        ParseClient.sharedInstance.fetchArticles(["type":"footwear"]) { (articles, error) in
            if let articles = articles {
                self.articles[2] = articles
                self.filteredArticles[2] = articles
                self.collectionView.reloadSections(NSIndexSet(index: 2))
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let count = articles[indexPath.section].count
        let size = count > 3 ? width / 3 : width / 2
        return CGSize(width: size, height: size)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "WardrobeTypeHeader", forIndexPath: indexPath) as! WardrobeTypeHeaderView
        
        let section = indexPath.section
        
        view.titleLabel.text = types[section]
        
        // Add expand/collapse gesture recognizer
        var tapGesture = CPTapGestureRecognizer(target: self, action: "toggleSection:")
        tapGesture.section = section
        view.addGestureRecognizer(tapGesture)
        
        
        // Add Expand Icon
        let isExpanded = expanded[section]
        view.expandButton.layer.transform = CATransform3DMakeRotation(angleForArrow(isExpanded), 0, 0, 1.0)
        
        // Add add Icon
        
        let addButton = view.addButton
        addButton.layer.cornerRadius = 12
        addButton.tintColor = UIColor.whiteColor()
        addButton.layer.backgroundColor = UIColor(white: 0.3, alpha: 1.0).CGColor
        
        tapGesture = CPTapGestureRecognizer(target: self, action: "addArticle:")
        tapGesture.section = section
        addButton.addGestureRecognizer(tapGesture)
        
        return view
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return expanded[section] ? filteredArticles[section].count : 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("WardrobeTypeCell", forIndexPath: indexPath) as! WardrobeTypeCell

        cell.article = filteredArticles[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func toggleSection(sender: CPTapGestureRecognizer) {
        let section = sender.section
        expanded[section] = !expanded[section]
        collectionView.reloadSections(NSIndexSet(index: section))
    }
    
    func sendPost(sender: UILongPressGestureRecognizer) {
        if sender.state == .Began {
            self.performSegueWithIdentifier(kPostArticleSegueIdentifier, sender: sender)
        }
    }

    func addArticle(sender: CPTapGestureRecognizer) {
        self.performSegueWithIdentifier(kAddArticleSegueIdentifier, sender: sender)
    }
    
    func angleForArrow(expanded: Bool) -> CGFloat {
        return CGFloat(expanded ? M_PI / 2.0 : M_PI * 1.5 )
    }
    
    // MARK: - SearchBar
    
/*    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        var searchOptions = [primaryColorKey, occasionKey, typeKey]
        let searchOption = searchOptions[searchSegmentedControl.selectedSegmentIndex]
        
        searchBar.resignFirstResponder()
        
        if searchBar.text! == "" {
            filteredArticles = articles
        } else {
            ParseClient.sharedInstance.fetchArticles([searchOption: searchBar.text!.lowercaseString, typeKey: "top"], completion: { (articleObjects: [Article]?, error: NSError?) in
                if let articleObjects = articleObjects {
                    print("Successfully searched articles: \(articleObjects.count)")
                    self.filteredArticles[0] = articleObjects
                    
                    self.tableView.reloadData()
                    
                } else {
                    let errorString = error!.userInfo["error"] as? NSString
                    print("Error message: \(errorString)")
                }
                
            })
            ParseClient.sharedInstance.fetchArticles([searchOption: searchBar.text!.lowercaseString, typeKey: "bottom"], completion: { (articleObjects: [Article]?, error: NSError?) in
                if let articleObjects = articleObjects {
                    print("Successfully searched articles: \(articleObjects.count)")
                    self.filteredArticles[0] = articleObjects
                    
                    self.tableView.reloadData()
                    
                } else {
                    let errorString = error!.userInfo["error"] as? NSString
                    print("Error message: \(errorString)")
                }
                
            })
            ParseClient.sharedInstance.fetchArticles([searchOption: searchBar.text!.lowercaseString, typeKey: "footwear"], completion: { (articleObjects: [Article]?, error: NSError?) in
                if let articleObjects = articleObjects {
                    print("Successfully searched articles: \(articleObjects.count)")
                    self.filteredArticles[0] = articleObjects
                    
                    self.tableView.reloadData()
                    
                } else {
                    let errorString = error!.userInfo["error"] as? NSString
                    print("Error message: \(errorString)")
                }
                
            })
        }
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.tableView.reloadData()
    }
    
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var article: Article?
        let destinationViewController = segue.destinationViewController
        
        if destinationViewController is ArticleViewController {
            if segue.identifier == kAddArticleSegueIdentifier {
                newArticleFlag = true
                let gesture = sender as! CPTapGestureRecognizer
                article = Article()
                switch (gesture.section) {
                case 0: article!.type = "top"
                case 1: article!.type = "bottom"
                default: article!.type = "footwear"
                }
                
                article!.owner = PFUser.currentUser()!
                
                // HACK
                article?.primaryColorCategories.appendContentsOf(["blue","green"])
            }
            else {  // Edit segue
                newArticleFlag = false
                let cell = sender as! WardrobeTypeCell
                article = cell.article
            }
            
            // Get the new view controller using segue.destinationViewController.
            if let articleController = segue.destinationViewController as? ArticleViewController {
                articleController.article = article
                articleController.delegate = self
            }
        }
    }
    
    func articleSaved(article: Article) {
        
        let articleType = article.type
        var saveInSection = -1
        
        if articleType == "top" {
            saveInSection = 0
        } else if articleType == "bottom" {
            saveInSection = 1
        } else if articleType == "footwear" {
            saveInSection = 2
        }
        
        if newArticleFlag {
            let indexPath = NSIndexPath(forRow: 0, inSection: saveInSection)
            articles[saveInSection].insert(article, atIndex: 0)
            // Option 1: Insert regardless of filter
            // Option 2: Insert if passes filter
            filteredArticles[saveInSection].insert(article, atIndex: 0)
            print("WardrobeViewController: New article added to tableview")
            
            collectionView.insertItemsAtIndexPaths([indexPath])
            // dismiss editor
        } else {
            //Update at same index
            //Update in articles list
            let articleIndex = articles[saveInSection].indexOf(article)
            let indexPath = NSIndexPath(forRow: articleIndex!, inSection: saveInSection)
            print("WardrobeViewController: Article at index \(articleIndex) updated")
            articles[saveInSection][articleIndex!] = article
            collectionView.reloadItemsAtIndexPaths([indexPath])
        }

    }

    func articleDeleted(article: Article) {
        
        let articleType = article.type
        var saveInSection = -1
        
        if articleType == "top" {
            saveInSection = 0
        } else if articleType == "bottom" {
            saveInSection = 1
        } else if articleType == "footwear" {
            saveInSection = 2
        }
        
        let articleIndex = articles[saveInSection].indexOf(article)
        let indexPath = NSIndexPath(forRow: articleIndex!, inSection: saveInSection)
        print("WardrobeViewController: Article at index \(articleIndex) deleted")
        
        articles[saveInSection].removeAtIndex(articleIndex!)
        filteredArticles[saveInSection].removeAtIndex(articleIndex!)
        
        collectionView.deleteItemsAtIndexPaths([indexPath])

        dismissViewControllerAnimated(true, completion: nil)
    }
}
