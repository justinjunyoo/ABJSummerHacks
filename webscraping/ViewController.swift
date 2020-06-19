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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    

    @IBOutlet weak var texasCases: UILabel!
    @IBOutlet weak var texasDeaths: UILabel!
    @IBOutlet weak var texasTitle: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
//    var vc = DataNumbers(nibName: nil, bundle: nil)
    var data = DataNumbers(nibName: nil, bundle: nil).allInfo()

    
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        

//        for i in 0...data.count - 1{
//            print(counties[i])
//        }
        self.texasTitle.text = "Texas Total"
        texasTitle.lineBreakMode = .byWordWrapping
        do {
            let url = URL(string: "https://www.worldometers.info/coronavirus/usa/texas/" )
            let html = try String(contentsOf: url!, encoding: String.Encoding.ascii)
            let doc:Document = try SwiftSoup.parse(html)

            var strTotalCases = " ";
            let caseCount = try doc.select("#usa_table_countries_today > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(2)")
            strTotalCases = try caseCount.text()
            strTotalCases = strTotalCases.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
            self.texasCases.text = "Cases: " + strTotalCases
            
            
            var strTotalDeaths = " ";
            let deathCount = try doc.select("#usa_table_countries_today > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(4)")
            strTotalDeaths = try deathCount.text()
            strTotalDeaths = strTotalDeaths.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
            self.texasDeaths.text = "Deaths: " + strTotalDeaths
        } catch Exception.Error(type: let type, Message: let message) {
            print(type)
            print(message)
        }catch{
            print("")
        }
        
  
//        texasCases.text = "Cases: " + String(data[0].cases)
//        texasCases.lineBreakMode = .byWordWrapping
//
//        texasDeaths.text = "Deaths: " + String(data[0].deaths)
//        texasDeaths.lineBreakMode = .byWordWrapping
//
        
        super.viewDidLoad()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return data.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100.0
          
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        cell.cellView.layer.cornerRadius = 20
        cell.selectionStyle = .none
        
        
    
        cell.name.text = String(data[indexPath.row].name)
        cell.name.lineBreakMode = .byWordWrapping

        cell.cases.text = String(data[indexPath.row].cases)
        cell.cases.lineBreakMode = .byWordWrapping

        cell.deaths.text = String(data[indexPath.row].deaths)
        cell.deaths.lineBreakMode = .byWordWrapping
        
        return cell
    }
 
    
}


