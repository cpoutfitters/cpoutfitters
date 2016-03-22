//
//  ImageLabelStackView.swift
//  CPOutfitters
//
//  Created by Eric Gonzalez on 3/12/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit

enum ImageLabelViewImageSide: Int {
    case Left, Right
}

@IBDesignable class ImageLabelView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var stackView: UIStackView!

    var gradientLayer: CAGradientLayer!
    var view: UIView!
    
    var imageSideLeft = true /*ImageLabelViewImageSide.Left*/ {
        didSet {
            if (imageSideLeft/* == .Left*/) != (stackView.arrangedSubviews.indexOf(imageView) == 0) {
                if imageSideLeft /*== .Left*/ {
                    stackView.removeArrangedSubview(labelView)
                    stackView.addArrangedSubview(labelView)
                }
                else {
                    stackView.removeArrangedSubview(imageView)
                    stackView.addArrangedSubview(imageView)
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

        gradientLayer = CAGradientLayer()
        layer.addSublayer(gradientLayer)
        
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass:self.dynamicType)
        let nib = UINib(nibName: "ImageLabelView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.layer.bounds
    }
}
