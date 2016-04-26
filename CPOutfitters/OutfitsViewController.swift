//
//  OutfitsViewController.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 03/04/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

let imageKey = "image"

class OutfitsViewController: UITableViewController {
    
    var genderFlag: String!
    
    var categories = [[occasionKey:"Casual",imageKey:"casual"],
                      [occasionKey:"Work",imageKey:"work"],
                      [occasionKey:"Date",imageKey:"date"],
                      [occasionKey:"Social",imageKey:"social"],
                      [occasionKey:"Formal",imageKey:"formal"],
                      [occasionKey:"Black Tie",imageKey:"blacktie"]]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        genderFlag = PFUser.currentUser()!["gender"] as? String == "Female" ? "f" : "m"
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("AttireCell", forIndexPath: indexPath) as! OutfitsCell
        let imageName = "\(categories[indexPath.row][imageKey]!)-\(genderFlag)"
        cell.categoryCell.imageView.image = UIImage(named: imageName)
        cell.categoryCell.labelView.text = categories[indexPath.row][occasionKey]
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor ( red: 0.8722, green: 0.8722, blue: 0.8722, alpha: 1.0 )
            cell.categoryCell.imageSideLeft = true
        } else {
            cell.backgroundColor = UIColor ( red: 1.0, green: 0.9998, blue: 0.9998, alpha: 1.0 )
            cell.categoryCell.imageSideLeft = false
        }
        
        //print(categories[indexPath.row])
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let outfit = Outfit()
        outfit.owner = PFUser.currentUser()!
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        let attire = categories[indexPath!.row][occasionKey]!
        
        if segue.identifier == "outfitSelect" {
            let outfitSelectionViewController = segue.destinationViewController as! OutfitSelectionViewController
            outfitSelectionViewController.attire = attire
            outfitSelectionViewController.outfit = outfit
        }
    }

}
