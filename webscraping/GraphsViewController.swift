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
        let cell = tableView.dequeueReusableCell(withIdentifier: "chartCell", for: indexPath) as! GraphsTableViewCell
        
        var str = [String]()
        var array = [Int]()
        
        for i in 0...data.count - 1{
            str.append(String(data[i].name))
        }
        
        
        
        if indexPath.row == 0 {
            
            for i in 0...data.count - 1{
                array.append(data[i].cases)
                cell.title.text = "Cases in Counties"
                cell.xTitle.text = "Counties"
                cell.yTitle.text = "Cases"
                cell.yTitle.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
                //255, 244, 229
                cell.backgroundColor = UIColor(red: 255/255, green: 244/255, blue: 229/255, alpha: 1)
            }
        }
            
        else if indexPath.row == 1 {
            for i in 0...data.count - 1{
                array.append(data[i].deaths)
                cell.title.text = "Deaths in Counties"
                cell.xTitle.text = "Counties"
                cell.yTitle.text = "Deaths"
                cell.yTitle.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
                cell.backgroundColor = UIColor.systemYellow
            }
        }
//        else if indexPath.row == 2{
//            cell = tableView.dequeueReusableCell(withIdentifier: "lineCell") as! GraphsTableViewCell
//        }
        
        cell.setBarChart(str: str, values: array)
        cell.selectionStyle = .none
        return cell
    }

}
