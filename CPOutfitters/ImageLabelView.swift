//
//  ImageLabelStackView.swift
//  CPOutfitters
//
//  Created by Eric Gonzalez on 3/12/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit

enum ImageLabelViewImageSide {
    case Left, Right
}

@IBDesignable class ImageLabelView: UIStackView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    
    var view: UIView!
    
    var imageSide = ImageLabelViewImageSide.Left {
        didSet {
            if (imageSide == .Left) != (arrangedSubviews.indexOf(imageView) == 0) {
                if imageSide == .Left {
                removeArrangedSubview(labelView)
                addArrangedSubview(labelView)
                }
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass:self.dynamicType)
        let nib = UINib(nibName: "ImageLabelView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
}