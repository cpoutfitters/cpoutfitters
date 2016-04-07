//
//  ArticleSelectionViewController.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 06/04/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

protocol ArticleSelectDelegate {
    func articleSelected(article: Article)
}

class ArticleSelectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var articleCollectionView: UICollectionView!
    
    var articles: [Article]?
    var delegate: ArticleSelectDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleCollectionView.dataSource = self
        articleCollectionView.delegate = self

    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let Articles = articles {
            return Articles.count
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = articleCollectionView.dequeueReusableCellWithReuseIdentifier("ArticleSelectCell", forIndexPath: indexPath) as! ArticleSelectCell
        
        cell.article = articles![indexPath.row]
        
        let articleTapAction = CPTapGestureRecognizer(target: self, action: "articleTap:")
        articleTapAction.section = indexPath.row
        cell.articleImageView.userInteractionEnabled = true
        cell.addGestureRecognizer(articleTapAction)
        
        return cell
    }
    
    func articleTap(sender: CPTapGestureRecognizer) {
        if sender.state != .Ended {
            return
        }
        if let index = sender.section {
            self.delegate?.articleSelected(articles![index])
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
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
