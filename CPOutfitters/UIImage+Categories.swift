//
//  UIImageView+Categories.swift
//  CPOutfitters
//
//  Created by Cory Thompson on 3/14/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit

extension UIImage {
    func resize(newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = self
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}