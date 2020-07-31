//
//  TexasAllTimeViewController.swift
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

class TexasAllTimeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var dates = [String]()
    let group = DispatchGroup()
    var alltimeTexas = [Double]()
    var dailyAllTexas = [Double]()
    var cnt : Int = 0
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        cnt += 1
        getFirestoreData()
        getDates()
        self.tableView.reloadData()
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.alltimeTexas.isEmpty == true{
            return 0
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "texasLineCell", for: indexPath) as! TexasAllLineTableViewCell
            cell.selectionStyle = .none
            if self.alltimeTexas.isEmpty == true{
                return cell
            }
            cell.setLineChart(str: self.dates, values: self.alltimeTexas)
            cell.lineChart.alpha = 1
            return cell
        }
        else{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "texasBarCell", for: indexPath) as! TexasAllBarTableViewCell
            cell2.selectionStyle = .none
            if self.alltimeTexas.isEmpty == true{
                return cell2
            }
            cell2.setBarChart(values: self.dailyAllTexas)
            cell2.barChart.alpha = 1
            return cell2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.height;
    }
    
    func getFirestoreData(){
        self.group.enter()
        Firestore.firestore().collection("TexasTotal").document("Texas Total").getDocument { (document, error) in
            if let document = document {
                self.group.leave()
                self.alltimeTexas = document["Trend_Cases"] as? Array ?? []
//                for i in dog.count-31...dog.count-1{
//                    self.alltimeTexas.append(dog[i] as! Double)
//                }
                
//                countyCollection = Firestore.firestore().collection("Counties").order(by: "Cases", descending: true)
//                citiesRef.orderBy("name", "desc").limit(3)
                for i in 0...self.alltimeTexas.count - 2{
                    let cnt = (self.alltimeTexas[i+1]-self.alltimeTexas[i])
                    if cnt < 20000{
                        self.dailyAllTexas.append(cnt)
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
    
    func getDates(){
            self.group.enter()
            Firestore.firestore().collection("TexasTotal").document("Dates").getDocument { (document, error) in
                if let document = document {
                    self.group.leave()
                    self.dates = document["Dates"] as? Array ?? []
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
