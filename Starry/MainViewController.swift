//
//  MainViewController.swift
//  Starry
//
//  Created by Chris Stroud on 10/9/15.
//  Copyright © 2015 HackNC. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    private var data = StorageController.allHacks()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.data = StorageController.allHacks()
        self.tableView.reloadData()
        if self.data.count == 0 {
            self.tableView.hidden = true
        } else {
            self.tableView.hidden = false
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(HackItemTableViewCell.identifier, forIndexPath: indexPath)
        if let cell = cell as? HackItemTableViewCell {
            let hackItem = self.data[indexPath.row]
            cell.titleLabel.text = hackItem.title
            cell.starView.ratingIndex = hackItem.rating
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let hackItem = self.data[indexPath.row]
        StorageController.removeHack(hackItem)
        self.data = StorageController.allHacks()
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        if self.data.count == 0 {
            self.tableView.hidden = true
        } else {
            self.tableView.hidden = false
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let cell = sender as? HackItemTableViewCell else {
            return
        }
        let indexPath = self.tableView.indexPathForCell(cell)!
        let hackItem = self.data[indexPath.row]
        if let controller = segue.destinationViewController as? HackInspectorViewController {
            controller.navigationItem.title = hackItem.title
            controller.ratingIndex = hackItem.rating
        }
    }
}

class HackItemTableViewCell:UITableViewCell {
    static let identifier = "hackItemCell"
    @IBOutlet weak var starView: StarView!
    @IBOutlet weak var titleLabel: UILabel!
}