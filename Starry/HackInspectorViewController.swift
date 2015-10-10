//
//  HackInspectorViewController.swift
//  Starry
//
//  Created by Chris Stroud on 10/9/15.
//  Copyright © 2015 HackNC. All rights reserved.
//

import UIKit

class HackInspectorViewController: UIViewController {

    var ratingIndex:Int = 0
    
    @IBOutlet weak var starView: StarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.starView.ratingIndex = self.ratingIndex
    }
}
