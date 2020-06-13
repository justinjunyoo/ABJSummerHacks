//
//  ViewController.swift
//  webscraping
//
//  Created by Aarish  Brohi on 5/30/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import SwiftSoup
import Charts

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    
    
    @IBOutlet weak var tableView: UITableView!
    
//    var vc = DataNumbers(nibName: nil, bundle: nil)
    var data = DataNumbers(nibName: nil, bundle: nil).allInfo()
    
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        data = vc.allInfo(dataArray: vc.values)
//        for i in 0...data.count - 1{
//            print(data[i].name, data[i].cases, data[i].deaths)
//        }
        
        super.viewDidLoad()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return data.count;
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        cell.cellView.layer.cornerRadius = 20
        
        cell.name.text = String(data[indexPath.row].name)
        cell.name.lineBreakMode = .byWordWrapping

        cell.cases.text = String(data[indexPath.row].cases)
        cell.cases.lineBreakMode = .byWordWrapping

        cell.deaths.text = String(data[indexPath.row].deaths)
        cell.deaths.lineBreakMode = .byWordWrapping
        
        cell.selectionStyle = .none
        return cell
    }
 
    
}
