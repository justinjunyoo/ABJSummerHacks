//
//  GraphsViewController.swift
//  webscraping
//
//  Created by Aarish  Brohi on 6/12/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import Charts

class GraphsViewController: UIViewController, UITableViewDelegate, ChartViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
  
    var data = ViewController(nibName: nil, bundle: nil).data
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            return 2;
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return tableView.frame.height 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "chartCell") as! GraphsTableViewCell
        
        var str = [String]()
        var array = [Int]()
        for i in 0...data.count - 1{
            str.append(String(data[i].name))
        }
        
        
        if indexPath.row == 0 {
            cell.TopTitle.text = "County Cases"
            cell.yTitle.text = "Number of Cases"
            cell.yTitle.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
            cell.backgroundColor = UIColor.systemBlue
            for i in 0...data.count - 1{
                array.append(data[i].cases)
            }
        }
            
        else if indexPath.row == 1 {
            cell.TopTitle.text = "County Deaths"
            cell.yTitle.text = "Number of Deaths"
            cell.yTitle.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
            cell.backgroundColor = UIColor.systemRed
            for i in 0...data.count - 1{
                array.append(data[i].deaths)
            }
        }
        
        cell.setChart(str: str, values: array)
        cell.selectionStyle = .none
        return cell
    }
    
   

}
