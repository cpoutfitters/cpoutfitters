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
