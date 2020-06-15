//
//  DataNumbers.swift
//  webscraping
//
//  Created by Aarish  Brohi on 6/10/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import SwiftSoup

class DataNumbers: UIViewController {

    
    var values = [County]()
    
    struct County{
        var name: String
        var cases: Int
        var deaths: Int
        
        init(name: String, cases: Int, deaths: Int) {
            self.name = name
            self.cases = cases
            self.deaths = deaths

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func allInfo() -> [County]{
        do {
            let url = URL(string: "https://www.worldometers.info/coronavirus/usa/texas/" )
            let html = try String(contentsOf: url!, encoding: String.Encoding.ascii)
            let doc:Document = try SwiftSoup.parse(html)

            let x = 12

            for i in 2...x{
                var str_county = " ";
                let counties = try doc.select("#usa_table_countries_today > tbody:nth-child(2) > tr:nth-child(\(i)) > td:nth-child(1)")
                str_county = try counties.text()
                if (i == 1){
                    str_county = str_county.replacingOccurrences(of: "Total", with: "", options: NSString.CompareOptions.literal, range: nil)
                    str_county = str_county.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
                }

                var str_case = " ";
                let case_count = try doc.select("#usa_table_countries_today > tbody:nth-child(2) > tr:nth-child(\(i)) > td:nth-child(2)")
                str_case = try case_count.text()
                str_case = str_case.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
                let num_cases = (str_case as NSString).integerValue

                var str_death = " ";
                let death_count = try doc.select("#usa_table_countries_today > tbody:nth-child(2) > tr:nth-child(\(i)) > td:nth-child(4)")
                str_death = try death_count.text()
                str_death = str_death.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
                let num_deaths = (str_death as NSString).integerValue
                
                
                let data = County(name: str_county, cases: num_cases, deaths: num_deaths)
                self.values.append(data)
            }
            
        }catch Exception.Error(type: let type, Message: let message) {
            print(type)
            print(message)
        }catch{
            print("")
        }
    
        return values;

    }
    
    
    func getName(i:Int)->String{
        var str_county = " ";
        do {
        let url = URL(string: "https://www.worldometers.info/coronavirus/usa/texas/" )
        let html = try String(contentsOf: url!, encoding: String.Encoding.ascii)
        let doc:Document = try SwiftSoup.parse(html)
            let counties = try doc.select("#usa_table_countries_today > tbody:nth-child(2) > tr:nth-child(\(i)) > td:nth-child(1)")
            str_county = try counties.text()
            if (i == 1){
                str_county = str_county.replacingOccurrences(of: "Total", with: "", options: NSString.CompareOptions.literal, range: nil)
                str_county = str_county.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
            }
        }catch Exception.Error(type: let type, Message: let message) {
            print(type)
            print(message)
        }catch{
            print("")
        }
            return String(str_county);
    }
    
    
    func getCases(i:Int)->String{
        var str_case = " ";
        do {
            let url = URL(string: "https://www.worldometers.info/coronavirus/usa/texas/" )
            let html = try String(contentsOf: url!, encoding: String.Encoding.ascii)
            let doc:Document = try SwiftSoup.parse(html)
            let case_count = try doc.select("#usa_table_countries_today > tbody:nth-child(2) > tr:nth-child(\(i)) > td:nth-child(2)")
            str_case = try case_count.text()
            str_case = str_case.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
        }catch Exception.Error(type: let type, Message: let message) {
            print(type)
            print(message)
        }catch{
            print("")
        }
            return String(str_case);
    }
    
    
    func getDeaths(i:Int)->String{
        var str_death = " ";
        do {
            let url = URL(string: "https://www.worldometers.info/coronavirus/usa/texas/" )
            let html = try String(contentsOf: url!, encoding: String.Encoding.ascii)
            let doc:Document = try SwiftSoup.parse(html)
            let death_count = try doc.select("#usa_table_countries_today > tbody:nth-child(2) > tr:nth-child(\(i)) > td:nth-child(4)")
            str_death = try death_count.text()
        }catch Exception.Error(type: let type, Message: let message) {
            print(type)
            print(message)
        }catch{
            print("")
        }
            return String(str_death);
    }
    
    
    func getData() -> [County] {
        return self.values;
    }
    
}
