//
//  TexasMonthlyViewController.swift
//  webscraping
//
//  Created by Aarish  Brohi on 7/23/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import Charts
import Firebase

class TexasMonthlyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dates = [String]()
    let group = DispatchGroup()
    var monthTexas = [Double]()
    var dailyMonthTexas = [Double]()
    var cnt : Int = 0
    
    override func viewDidLoad() {
        tableView.backgroundColor = AppDelegate().uicolorFromHex(rgbValue: 0x313547)
        tableView.delegate = self
        tableView.dataSource = self
        cnt += 1
        getFirestoreData()
        DataNumbers().getDates(){ (keys) in
            let dog = keys
            for i in dog.count-31...dog.count-1{
                self.dates.append(dog[i])
            }
            self.tableView.reloadData()
        }
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.monthTexas.isEmpty == true{
            return 0
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.height;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "texasMonthLineCell", for: indexPath) as! TexasMonthlyLineTableViewCell
            cell.selectionStyle = .none
            if self.monthTexas.isEmpty == true{
                return cell
            }
            cell.setLineChart(str: self.dates, values: self.monthTexas)
            cell.chartTitle.text = "Texas Monthly Cases"
            cell.chartTitle.textColor = .lightText
            cell.yaxis.text = "Cases"
            cell.yaxis.transform = CGAffineTransform(rotationAngle: 3 * CGFloat.pi / 2)
            cell.yaxis.textColor = .lightText
            return cell
        }
        else{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "texasMonthBarCell", for: indexPath) as! TexasMonthlyBarTableViewCell
            cell2.selectionStyle = .none
            if self.monthTexas.isEmpty == true{
                return cell2
            }
            cell2.setBarChart(str: self.dates, values: self.dailyMonthTexas)
            cell2.chartTitle.text = "Texas Monthly Cases"
            cell2.chartTitle.textColor = .lightText
            cell2.yaxis.text = "Cases"
            cell2.yaxis.transform = CGAffineTransform(rotationAngle: 3 * CGFloat.pi / 2)
            cell2.yaxis.textColor = .lightText
            return cell2
        }
    }
    
    func getFirestoreData(){
            self.group.enter()
            Firestore.firestore().collection("TexasTotal").document("Texas Total").getDocument { (document, error) in
                if let document = document {
                    self.group.leave()
                    let dog = document["Trend_Cases"] as? Array ?? []
                    for i in dog.count-31...dog.count-1{
                        self.monthTexas.append(dog[i] as! Double)
                    }
                    for i in 0...self.monthTexas.count - 2{
                        let cnt = (self.monthTexas[i+1]-self.monthTexas[i])
                        self.dailyMonthTexas.append(cnt)
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
