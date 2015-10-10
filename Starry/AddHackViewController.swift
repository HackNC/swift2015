//
//  AddHackViewController.swift
//  Starry
//
//  Created by Chris Stroud on 10/9/15.
//  Copyright © 2015 HackNC. All rights reserved.
//

import UIKit

class AddHackViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    
    
    @IBAction func cancelButtonSelected(sender: AnyObject) {
        self.dismiss()
    }
    
    @IBAction func doneButtonSelected(sender: AnyObject) {
        
        let ratingCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! AddHackRatingTableViewCell
        let title = self.titleTextField.text!
        let rating = ratingCell.starView.ratingIndex
        let newHack = Hack(title:title, rating:rating)
        StorageController.persistHack(newHack)
        self.dismiss()
    }
    
    private func dismiss() {
        if let presentingViewController = self.presentingViewController {
            presentingViewController.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    func textFieldDidEndEditing(textField: UITextField) {
        self.updateDoneButton()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        //
        // Artificially spin the runloop so this executes *after*
        // the textField actually updates its value
        //
        dispatch_async(dispatch_get_main_queue()) {[weak self] in
            self?.updateDoneButton()
        }
        return true
    }
    
    private func updateDoneButton() {
        let validName = (self.titleTextField.text?.unicodeScalars.count > 0) ?? false
        self.doneButton.enabled = validName
    }
}

class AddHackRatingTableViewCell:UITableViewCell {
    @IBOutlet weak var starView: StarView!
}

