//
//  GraphsViewController.swift
//  webscraping
//
//  Created by Aarish  Brohi on 6/12/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit


class GraphsViewController: UIViewController{
    
    @IBOutlet weak var monthView: UIView!
    @IBOutlet weak var allTimeView: UIView!
    @IBOutlet weak var weekView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            allTimeView.alpha = 1
            monthView.alpha = 0
            weekView.alpha = 0
        }
        else if sender.selectedSegmentIndex == 1{
            allTimeView.alpha = 0
            monthView.alpha = 1
            weekView.alpha = 0
            
        }
        else{
            allTimeView.alpha = 0
            monthView.alpha = 0
            weekView.alpha = 1
        }
    }
    


}
