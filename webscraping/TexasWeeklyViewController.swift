//
//  TexasWeeklyViewController.swift
//  webscraping
//
//  Created by Aarish  Brohi on 7/23/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import Charts
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift


class TexasWeeklyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    
    let group = DispatchGroup()
    var weekTexas = [Double]()
    var dailyweekTexas = [Double]()
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
        if self.weekTexas.isEmpty == true{
            return 0
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.height;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "texasWeeklyLineCell", for: indexPath) as! TexasWeeklyLineTableViewCell
            cell.selectionStyle = .none
            if self.weekTexas.isEmpty == true{
                return cell
            }
            cell.setLineChart(values: self.weekTexas)
            cell.lineChart.alpha = 1
            return cell
        }
        else{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "texasWeeklyBarCell", for: indexPath) as! TexasWeeklyBarTableViewCell
            cell2.selectionStyle = .none
            if self.weekTexas.isEmpty == true{
                return cell2
            }
            cell2.setBarChart(values: self.dailyweekTexas)
            cell2.barChart.alpha = 1
            return cell2
        }
    }
    
    
    func getFirestoreData(){
        self.group.enter()
        Firestore.firestore().collection("TexasTotal").document("Texas Total").getDocument { (document, error) in
            if let document = document {
                self.group.leave()
                let dog = document["Trend_Cases"] as? Array ?? []
                for i in dog.count-9...dog.count-1{
                    self.weekTexas.append(dog[i] as! Double)
                }
                for i in 0...self.weekTexas.count - 2{
                    let cnt = (self.weekTexas[i+1]-self.weekTexas[i])
                    if cnt < 20000{
                        self.dailyweekTexas.append(cnt)
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
