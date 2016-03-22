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
    var expanded = [true, true, true]
    
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
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ImageLabelView(frame: CGRectZero)//(origin: CGPointZero, size: CGSize(width: tableView.bounds.width, height: 100)))
        
        view.imageSideLeft = false
        view.labelView.text = types[section]
        
        let tapGesture = CPTapGestureRecognizer(target: self, action: "toggleSection:")
        tapGesture.section = section
        view.addGestureRecognizer(tapGesture)
        
        let expandButton = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        expandButton.image = UIImage(named: "arrow")
        let isExpanded = expanded[section]
        expandButton.layer.transform = CATransform3DMakeRotation(angleForArrow(isExpanded), 0, 0, 1.0)
        
        view.addSubview(expandButton)
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem: expandButton, attribute: .CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .Bottom, relatedBy: .Equal, toItem: expandButton, attribute: .Bottom, multiplier: 1.0, constant: 0))

        return view
    }
    
    func toggleSection(sender: CPTapGestureRecognizer) {
        let section = sender.section
        expanded[section] = !expanded[section]
        tableView.reloadSections(NSIndexSet(index: section), withRowAnimation: .Automatic)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return typeListing[types[section]]!.count
        return expanded[section] ? 2 : 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WardrobeTypeCell", forIndexPath: indexPath) as! WardrobeTypeCell

        cell.type = "Shirt"
        
        return cell
    }
    
    func angleForArrow(expanded: Bool) -> CGFloat {
        return CGFloat(expanded ? M_PI / 2.0 : M_PI * 1.5 )
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
