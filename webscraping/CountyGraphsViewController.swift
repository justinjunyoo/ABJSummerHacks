//
//  CountyGraphsViewController.swift
//  webscraping
//
//  Created by Aarish  Brohi on 7/28/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit

class CountyGraphsViewController: UIViewController {

    
    @IBOutlet weak var allTimeView: UIView!
    @IBOutlet weak var weeklyView: UIView!
    @IBOutlet weak var monthlyView: UIView!
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
            monthlyView.alpha = 0
            weeklyView.alpha = 0
        }
        else if segment.selectedSegmentIndex == 1{
            allTimeView.alpha = 0
            monthlyView.alpha = 1
            weeklyView.alpha = 0
        }
        else{
            allTimeView.alpha = 0
            monthlyView.alpha = 0
            weeklyView.alpha = 1
        }
    }
    
    @objc func swipedLeft(){
        segment.selectedSegmentIndex += 1
        if segment.selectedSegmentIndex > 2{
        segment.selectedSegmentIndex = 2
        }
        if segment.selectedSegmentIndex == 0{
            allTimeView.alpha = 1
            monthlyView.alpha = 0
            weeklyView.alpha = 0
        }
        else if segment.selectedSegmentIndex == 1{
            allTimeView.alpha = 0
            monthlyView.alpha = 1
            weeklyView.alpha = 0
        }
        else{
            allTimeView.alpha = 0
            monthlyView.alpha = 0
            weeklyView.alpha = 1
        }
    }
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            allTimeView.alpha = 1
            monthlyView.alpha = 0
            weeklyView.alpha = 0
        }
        else if sender.selectedSegmentIndex == 1{
            allTimeView.alpha = 0
            monthlyView.alpha = 1
            weeklyView.alpha = 0
            
        }
        else{
            allTimeView.alpha = 0
            monthlyView.alpha = 0
            weeklyView.alpha = 1
        }
    }
    
    @IBAction func leaveView(_ sender: Any) {
        UserDefaults.resetStandardUserDefaults()
        self.dismiss(animated: true, completion: nil)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}

