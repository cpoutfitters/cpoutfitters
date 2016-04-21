//
//  OutfitsViewController.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 03/04/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class OutfitsViewController: UITableViewController {
    
    var categories = ["Casual", "Work" ,"Date", "Social", "Formal", "Black Tie"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let cell:OutfitsCell
        if indexPath.row % 2 == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier("AttireCell", forIndexPath: indexPath) as! OutfitsCell
            cell.categoryLabel.text = categories[indexPath.row]
            cell.categoryImage.image = UIImage(named: categories[indexPath.row])
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier("AttireCell2", forIndexPath: indexPath) as! OutfitsCell
            cell.inverseCategoryLabel.text = categories[indexPath.row]
            cell.inverseCategoryImage.image = UIImage(named: categories[indexPath.row])
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
        var outfit = Outfit()
        outfit.owner = PFUser.currentUser()!
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        let attire = categories[indexPath!.row]
        
        if segue.identifier == "outfitSelect" {
            let outfitSelectionViewController = segue.destinationViewController as! OutfitSelectionViewController
            outfitSelectionViewController.attire = attire
            outfitSelectionViewController.outfit = outfit
        }
    }

}
