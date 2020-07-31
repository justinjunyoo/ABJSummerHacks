//
//  CountyWeeklyViewController.swift
//  webscraping
//
//  Created by Aarish  Brohi on 7/28/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import Charts
import Firebase

class CountyWeeklyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let allTime = UserDefaults.standard.string(forKey: "name")
    let group = DispatchGroup()
    var weekCounty = [Double]()
    var dailyweekCounty = [Double]()
    var cnt : Int = 0
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        cnt += 1
        getFirestoreData()
        self.tableView.reloadData()
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.weekCounty.isEmpty == true{
            return 0
        }
        return 2
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.height;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "countyWeeklyLineCell", for: indexPath) as! CountyWeeklyLineTableViewCell
            cell.selectionStyle = .none
            if self.weekCounty.isEmpty == true{
                return cell
            }
            cell.setLineChart(values: self.weekCounty)
            cell.lineChart.alpha = 1
            return cell
        }
        else{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "countyWeeklyBarCell", for: indexPath) as! CountyWeeklyBarTableViewCell
            cell2.selectionStyle = .none
            if self.weekCounty.isEmpty == true{
                return cell2
            }
            cell2.setBarChart(values: self.dailyweekCounty)
            cell2.barChart.alpha = 1
            return cell2
        }
    }
        
        
    func getFirestoreData(){
        self.group.enter()
        Firestore.firestore().collection("Counties").document("\(String(allTime ?? "Texas Total"))").getDocument { (document, error) in
            if let document = document {
                self.group.leave()
                let dog = document["Trend_Cases"] as? Array ?? []
                for i in dog.count-9...dog.count-1{
                    self.weekCounty.append(dog[i] as! Double)
                }
                for i in 0...self.weekCounty.count - 2{
                    let cnt = (self.weekCounty[i+1]-self.weekCounty[i])
                    if cnt < 20000{
                        self.dailyweekCounty.append(cnt)
                    }
                }
                if self.cnt == 1{
                    self.tableView.reloadData()
                }
            }
            else if let err = error{
                debugPrint("Error: \(err)")
            }
        }
    }
       
}
