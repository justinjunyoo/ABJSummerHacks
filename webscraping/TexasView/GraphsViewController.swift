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
    @IBOutlet weak var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedRight))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedLeft))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        
        view.addGestureRecognizer(swipeRight)
        view.addGestureRecognizer(swipeLeft)
        super.viewDidLoad()
    }
    
    @objc func swipedRight(){
        segment.selectedSegmentIndex -= 1
        if segment.selectedSegmentIndex < 0{
            segment.selectedSegmentIndex = 0
        }
        if segment.selectedSegmentIndex == 0{
            allTimeView.alpha = 1
            monthView.alpha = 0
            weekView.alpha = 0
        }
        else if segment.selectedSegmentIndex == 1{
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

    @objc func swipedLeft(){
        segment.selectedSegmentIndex += 1
        if segment.selectedSegmentIndex > 2{
            segment.selectedSegmentIndex = 2
        }
        if segment.selectedSegmentIndex == 0{
            allTimeView.alpha = 1
            monthView.alpha = 0
            weekView.alpha = 0
        }
        else if segment.selectedSegmentIndex == 1{
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


