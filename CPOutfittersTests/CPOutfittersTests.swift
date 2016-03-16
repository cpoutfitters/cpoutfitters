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
        article.owner = user
        article.type = "shirt"
        article.short = true
        article.primaryColor = "blue"
        article.primaryColorCategories = ["blue", "green"]
        article.occasion = ["casual"]
        article.favorite = false
        article.sharedWith = nil
        article.mediaImage = nil
        article.lastWorn = NSDate()
        article.useCount = 1
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testArticles_QueryToLoad_ArticleFetch() {
        
        //create and populate, store, fetch and then compare
        let query = PFQuery(className: "Article")
        
        query.findObjectsInBackgroundWithBlock { (object: [PFObject]?, error: NSError?) in
            XCTAssertEqual(self.article.type!, "shirt", "Article fetch failure")
        }
        
        article.deleteInBackground()
    }
    func testArticle_SaveToLocal_ArticleStored() {
        /*
         Test article creation and save it in local data store
         */
        article.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) in
            if (success == true) {
            XCTAssertTrue(success, "Article save failure")
            }
        })
    }
}
