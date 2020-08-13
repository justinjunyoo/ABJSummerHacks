//
//  TexasAllTimeViewController.swift
//  webscraping
//
//  Created by Aarish  Brohi on 7/23/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import Charts
import Firebase

class TexasAllTimeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!

    var dates = [String]()
    let group = DispatchGroup()
    var alltimeTexas = [Double]()
    var dailyAllTexas = [Double]()
    var cnt : Int = 0
    
    override func viewDidLoad() {
        tableView.backgroundColor = AppDelegate().uicolorFromHex(rgbValue: 0x313547)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        cnt += 1
        getFirestoreData()
        DataNumbers().getDates(){ (keys) in
            self.dates = keys
            self.tableView.reloadData()
        }
        
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
            cell.chartTitle.text = "Texas All-Time Cases"
            cell.chartTitle.textColor = .lightText
            cell.yaxis.text = "Cases"
            cell.yaxis.transform = CGAffineTransform(rotationAngle: 3 * CGFloat.pi / 2)
            cell.yaxis.textColor = .lightText
            return cell
        }
        else{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "texasBarCell", for: indexPath) as! TexasAllBarTableViewCell
            cell2.selectionStyle = .none
            if self.alltimeTexas.isEmpty == true{
                return cell2
            }
            cell2.setBarChart(str: self.dates, values: self.dailyAllTexas)
            cell2.chartTitle.text = "Texas All-Time Cases"
            cell2.chartTitle.textColor = .lightText
            cell2.yaxis.text = "Cases"
            cell2.yaxis.transform = CGAffineTransform(rotationAngle: 3 * CGFloat.pi / 2)
            cell2.yaxis.textColor = .lightText
//            cell2.yaxis.lineBreakMode = .byWordWrapping
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
                for i in 0...self.alltimeTexas.count - 2{
                    let cnt = (self.alltimeTexas[i+1]-self.alltimeTexas[i])
                    self.dailyAllTexas.append(cnt)
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
