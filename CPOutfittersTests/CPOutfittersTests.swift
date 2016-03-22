//
//  CPOutfittersTests.swift
//  CPOutfittersTests
//
//  Created by Aditya Purandare on 14/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import XCTest
import Parse

@testable import CPOutfitters

class CPOutfittersTests: XCTestCase {
    
    let article = Article()
    var articles: [Article]?
    
    override func setUp() {
        super.setUp()
        
        // Mockup for Article class object
        article.owner = PFUser.currentUser()!
        article.type = "shirt"
        article.short = true
        article.primaryColor = "blue"
        article.primaryColorCategories = ["blue", "green"]
        article.occasion = ["casual"]
        article.favorite = false
        article.sharedWith = nil
        article.mediaImage = Article.getPFFileFromImage(UIImage(named: "event"))
        article.lastWorn = NSDate()
        article.useCount = 1
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testArticles() {
        saveArticle()
        queryArticleFetch()
        deleteArticle()
    }
    
    func queryArticleFetch() {
        /*
        Test article to fetch from Parse server, compare the values and delete it.
        */
        //        let query = PFQuery(className: "Article")
        //        query.fromLocalDatastore()
        //        query.whereKey("owner", equalTo: PFUser.currentUser()!)
        //        let objects = try! query.findObjects()
        //        XCTAssert(objects.count > 0, "Objects not found matching owner")
        //        let articles = Article.articlesWithArray(objects)
        //        XCTAssert(articles.count > 0, "Articles not retrieved")
        //        for element in articles {
        //            XCTAssertEqual(element.type, "shirt", "Article fetch failure")
        //        }
        //        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
        //            let articles = Article.articlesWithArray(objects!)
        //            for element in articles {
        //                XCTAssertEqual(element.type, "shirt", "Article fetch failure")
        //            }
        //        }
        
        ParseClient.sharedInstance.fetchArticles(["key":"value"], completion: { (articles: [Article]?, error: NSError?) in
            self.articles = articles
            print("I am fetching articles")
            if articles != nil {
                XCTAssert(articles!.count > 0, "Objects not found matching owner")
            } else {
                XCTFail("Error in fetching failure")
            }
        })
        XCTAssert(self.articles!.count > 0, "Objects not found matching owner")

    }
    
    func saveArticle() {
        /*
         Test article creation and saving it in local data store.
         */
        
        ParseClient.sharedInstance.saveArticle(self.article, completion: { (success, error) in
            if (success == true) {
                XCTAssertTrue(success!, "Article save failure")
            } else {
                XCTFail("Failed to save article")
                print(error?.localizedDescription)
            }
        })
    }
    
    func deleteArticle() {
       
        ParseClient.sharedInstance.deleteArticle(self.article) { (success, error) in
            if (success == true) {
                XCTAssertTrue(success!, "Article delete failure")
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
}
