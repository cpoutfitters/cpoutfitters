//
//  WardrobeViewController.swift
//  CPOutfitters
//
//  Created by Eric Gonzalez on 3/10/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit

class WardrobeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var types = ["Tops", "Bottoms", "Footwear"]
    
    var typeListing = [
        "Tops":["Shirts", "Dresses", "Blouses", "Jackets", "Coats", "Vests"],
        "Bottoms":["Pants", "Shorts", "Skirts"],
        "Footwear":["Shoes", "Boots"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section {
//        case 0: return "Tops"
//        case 1: return "Bottoms"
//        default: return "Footwear"
//        }
//    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ImageLabelView(frame: CGRectZero)//(origin: CGPointZero, size: CGSize(width: tableView.bounds.width, height: 100)))
        
        view.imageSide = .Right
        
        var title: String
        switch section {
        case 0: title = "Tops"
        case 1: title = "Bottoms"
        default: title = "Footwear"
        }
        
        view.labelView.text = title

        return view
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeListing[types[section]]!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WardrobeTypeCell", forIndexPath: indexPath) as! WardrobeTypeCell

        cell.type = typeListing[types[indexPath.section]]![indexPath.row]
        cell.containerView.imageSide = ImageLabelViewImageSide(rawValue: (indexPath.row % 2))!
        
        return cell
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
