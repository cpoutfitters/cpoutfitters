//
//  Post.swift
//  CPOutfitters
//
//  Created by Cory Thompson on 4/6/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    class func postUserImage(image: UIImage?, withCaption caption: NSString?, withCompletion completion: PFBooleanResultBlock?) {
        let post = PFObject(className: "Post")
        post["image"] = Article.getPFFileFromImage(image)
        post["author"] = PFUser.currentUser()
        post["caption"] = caption
        
        post.saveInBackgroundWithBlock(completion)
    }
}
