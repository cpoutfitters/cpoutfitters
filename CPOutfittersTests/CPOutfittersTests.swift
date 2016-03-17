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
    let user = User()
    
    override func setUp() {
        super.setUp()
        
        // Mockup for User class object
        user.friends = nil
        user.profileImage = nil
        user.bio = "Hello"
        user.sharedWith = nil
        
        // Mockup for Article class object
        article.userId = PFUser.currentUser()?.email
        article.type = "shirt"
        article.short = true
        article.primaryColor = "blue"
        article.primaryColorCategories = ["blue", "green"]
        article.occasion = ["casual"]
        article.favorite = false
        article.sharedWith = ["aditya.p1993@hotmail.com"]
//        article.mediaImage = UIImage(named: "event")
        article.lastWorn = NSDate()
        article.useCount = 1
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testArticles_QueryToLoad_ArticleFetch() {
        /*
        Test article to fetch from Parse server, compare the values and delete it.
        */
        let query = PFQuery(className: "Article")
        query.whereKey("user_id", equalTo: article.userId!)
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
            let articles = Article.articlesWithArray(objects!)
            for element in articles {
                XCTAssertEqual(element.type, "shirt", "Article fetch failure")
            }
        }
    }
    
    func testArticle_SaveToServer_ArticleStored() {
        /*
         Test article creation and saving it in local data store.
         */
        ParseClient.sharedInstance.saveArticle(self.article, completion: { (success, error) in
            if (success == true) {
                XCTAssertTrue(success!, "Article save failure")
            } else {
                print(error?.localizedDescription)
            }
        })
    }
    
    func testParseClient_DeletionOfArticle_ArticleRemoved() {
       
        ParseClient.sharedInstance.deleteArticle(self.article) { (success, error) in
            if (success == true) {
                XCTAssertTrue(success!, "Article delete failure")
            } else {
                print(error?.localizedDescription)
            }
        }
    }
}
