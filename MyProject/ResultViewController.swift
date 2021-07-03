//
//  ResultViewController.swift
//  MyProject
//
//  Created by Emil Shukurov on 02/07/2021.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var mon: UILabel!
    
    var results = "0.0"
    override func viewDidLoad() {
        super.viewDidLoad()
        mon.text = results
        
    }
}
