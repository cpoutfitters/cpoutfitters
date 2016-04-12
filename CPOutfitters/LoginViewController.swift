//
//  LoginViewController.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 08/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import ParseUI

class LoginViewController: PFLogInViewController {

    var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailAsUsername = true
        fields = [.UsernameAndPassword,  .LogInButton, .PasswordForgotten, .SignUpButton, .Facebook, .Twitter]
        
        let logo = UILabel()
        logo.text = "CPOutfitters"
        logo.textColor = UIColor.whiteColor()
        logo.font = UIFont(name: "Helvetica", size: 40)
//        logo.shadowColor = UIColor.lightGrayColor()
        logo.shadowColor = UIColor.blackColor()
        logo.shadowOffset = CGSizeMake(2, 2)
        logInView?.logo = logo
        
        logInView!.logo!.sizeToFit()
        let logoFrame = logInView!.logo!.frame
        logInView!.logo!.frame = CGRectMake(logoFrame.origin.x, logInView!.usernameField!.frame.origin.y - logoFrame.height - 16, logInView!.frame.width, logoFrame.height)
                
        backgroundImageView = UIImageView(image: UIImage(named: "LoginBackground"))
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.logInView!.insertSubview(backgroundImageView, atIndex: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backgroundImageView.frame = CGRectMake(0, 0, self.logInView!.frame.width, self.logInView!.frame.height)
    }
    
    //override func

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
