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


import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    public struct County : Codable{
        var name: String
        var cases: Int
        var deaths: Int
        
        init(name: String, cases: Int, deaths: Int) {
            self.name = name
            self.cases = cases
            self.deaths = deaths
        }
    }
    
    @IBOutlet weak var texasCases: UILabel!
    @IBOutlet weak var texasDeaths: UILabel!
    @IBOutlet weak var texasTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var db: Firestore!
    var data = [County]()
    var cnt : Int = 0
    var countyCollection : Query!
    let group = DispatchGroup()
    var data2 = [County]()
//    var data2 = ViewController(nibName: nil, bundle: nil).allInfo2()

    
//    let dispa = DispatchGroup()
    
    override func viewDidLoad() {
//        print(data2.isEmpty , "dog")
        tableView.delegate = self
        tableView.dataSource = self
//        FirebaseViewController(nibName: nil, bundle: nil).getData()
        countyCollection = Firestore.firestore().collection("Counties").order(by: "Cases", descending: true)

        
        print("Before starting to get documents");
        cnt += 1;
        
        data = self.allInfo2()
        print("After starting to get documents");
        if(data.isEmpty == false){
            self.texasTitle.text = "Texas Total"
            texasTitle.lineBreakMode = .byWordWrapping

            texasCases.text = "Cases: " + String(data[0].cases)
            texasCases.lineBreakMode = .byWordWrapping

            texasDeaths.text = "Deaths: " + String(data[0].deaths)
            texasDeaths.lineBreakMode = .byWordWrapping
        }
        self.tableView.reloadData()
        setGraphData()
        super.viewDidLoad()
    }
    
    public func setGraphData(){
        data2 = self.data
    }
    
    
    public func allInfo2() -> [County]{
        print("begin")
        self.group.enter()
        countyCollection.getDocuments { (snapshot, error) in

            if let err = error{
                debugPrint("Error: \(err)")
                return
            }
            else{
                self.group.leave()
                guard let snap = snapshot else {return}
                for documents in snap.documents{
                    let name2 = (documents["Name"] as? String)
                    let cases2 = (documents["Cases"] as? Int)
                    let deaths2 = (documents["Deaths"] as? Int)
                    let data2 = County(name: name2!, cases: cases2!, deaths: deaths2!)
                    self.data.append(data2)
                }
                self.texasTitle.text = "Texas Total"
                self.texasTitle.lineBreakMode = .byWordWrapping

                self.texasCases.text = "Cases: " + String(self.data[0].cases)
                self.texasCases.lineBreakMode = .byWordWrapping

                self.texasDeaths.text = "Deaths: " + String(self.data[0].deaths)
                self.texasDeaths.lineBreakMode = .byWordWrapping
                
//                let defaults = UserDefaults.standard
//                if let data = defaults.data(forKey: "SavedItemArray") {
//                    let array = try! PropertyListDecoder().decode([County].self, from: data)
//                }
//                UserDefaults.standard.set(try? PropertyListEncoder().encode(self.data), forKey:"key")
                var cases_cnt = [Int]()
                var deaths_cnt = [Int]()
                var names_cnt = [String]()
                for i in 0...self.data.count-1{
                    cases_cnt.append(self.data[i].cases)
                    deaths_cnt.append(self.data[i].deaths)
                    names_cnt.append(self.data[i].name)
                }
                UserDefaults.resetStandardUserDefaults()
                if self.cnt == 1 {
                    UserDefaults.resetStandardUserDefaults()
                    UserDefaults.standard.set(cases_cnt, forKey: "case_count")
                    UserDefaults.standard.set(deaths_cnt, forKey: "death_count")
                    UserDefaults.standard.set(names_cnt, forKey: "name_count")
        
                    self.viewDidLoad()
                }
            }
        }
        print("end")
//        self.group.wait()
        return data
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if(data.isEmpty == true){
            return 0
        }
        return data.count - 1

    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100.0
          
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        if(data.isEmpty == true){
            return cell
        }
        else{
            cell.cellView.layer.cornerRadius = 20
            cell.selectionStyle = .none

            cell.name.text = String(data[indexPath.row + 1].name)
            cell.name.lineBreakMode = .byWordWrapping

            cell.cases.text = String(data[indexPath.row + 1].cases)
            cell.cases.lineBreakMode = .byWordWrapping

            cell.deaths.text = String(data[indexPath.row + 1].deaths)
            cell.deaths.lineBreakMode = .byWordWrapping
            
        }
        return cell
    }
 


}

