//
//  ViewController.swift
//  webscraping
//
//  Created by Aarish  Brohi on 5/30/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import Firebase

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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var texasCases: UILabel!
    @IBOutlet weak var texasDeaths: UILabel!
    @IBOutlet weak var texasTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var searchCounty:[County]? = []
    var searching = false
    var data = [County]()
    var cnt : Int = 0
    var countyCollection : Query!
    let group = DispatchGroup()
    var data2 = [County]()
    var texasCasesTitle = 0
    var texasDeathsTitle = 0
    
    override func viewDidLoad() {
        
        hideKeyboardWhenTappedAround()
        
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search County..."
        tableView.delegate = self
        tableView.dataSource = self
        countyCollection = Firestore.firestore().collection("Counties").order(by: "Cases", descending: true)
        
        self.allInfo2(){
            self.texasTitle.text = "Texas"
            self.texasTitle.lineBreakMode = .byWordWrapping

            self.texasCases.text = "Cases: " + String(self.data[0].cases)
            self.texasCases.lineBreakMode = .byWordWrapping

            self.texasDeaths.text = "Deaths: " + String(self.data[0].deaths)
            self.texasDeaths.lineBreakMode = .byWordWrapping
            self.data.removeFirst()
            self.tableView.reloadData()
        }
        
        super.viewDidLoad()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !searching{
            UserDefaults.standard.set(self.data[indexPath.row].name, forKey: "name")
        }
        else{
            UserDefaults.standard.set(self.searchCounty![indexPath.row].name, forKey: "name")
        }
        tableView.deselectRow(at: indexPath, animated: true)
        let view = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "graph") as! CountyGraphsViewController
        _ = view.view
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: true, completion: nil)
    }
    
    
    public func allInfo2(completion: @escaping () -> ()){
        countyCollection.getDocuments { (snapshot, error) in
            if let err = error{
                debugPrint("Error: \(err)")
                completion()
            }
            else{
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
                

                var cases_cnt = [Int]()
                var deaths_cnt = [Int]()
                var names_cnt = [String]()
                for i in 0...self.data.count-1{
                    cases_cnt.append(self.data[i].cases)
                    deaths_cnt.append(self.data[i].deaths)
                    names_cnt.append(self.data[i].name)
                }
                completion()
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if searching{
            return self.searchCounty?.count ?? 0
        }
        return data.count - 1

    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
          
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        cell.cellView.layer.cornerRadius = 20
        
        if !searching{
            cell.name.text = String(data[indexPath.row].name)
            cell.name.lineBreakMode = .byWordWrapping
            
            cell.cases.text = String(data[indexPath.row].cases)
            cell.cases.lineBreakMode = .byWordWrapping
            
            cell.deaths.text = String(data[indexPath.row].deaths)
            cell.deaths.lineBreakMode = .byWordWrapping
        }
        else{
            if (searchCounty![indexPath.row].name != "Texas Total"){
                cell.name.text = String(searchCounty![indexPath.row].name)
                cell.name.lineBreakMode = .byWordWrapping
                
                cell.cases.text = String(searchCounty![indexPath.row].cases)
                cell.cases.lineBreakMode = .byWordWrapping
                
                cell.deaths.text = String(searchCounty![indexPath.row].deaths)
                cell.deaths.lineBreakMode = .byWordWrapping
            }
        }
        return cell
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCounty = data.filter({$0.name.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
}


