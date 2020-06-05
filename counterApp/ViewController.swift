//
//  ViewController.swift
//  counterApp
//
//  Created by Brandon Pham on 5/20/20.
//  Copyright © 2020 Brandon Pham. All rights reserved.
//

import UIKit
import SwiftSoup
class ViewController: UIViewController {

    @IBOutlet weak var totalCountLabel: UILabel!
    
//    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let url = URL(string:"https://www.worldometers.info/coronavirus/")
            let html = try String(contentsOf: url!, encoding:String.Encoding.ascii)
            let doc: Document = try SwiftSoup.parse(html)
            let temp: Element = try doc.select("h1").first()!
            totalCountLabel.text = String(temp)
        } catch Exception.Error(type: let type, Message: let message) {
            print(type)
            print(message)
        } catch {
            print("")
        }
        
    }

//    @IBAction func addToCounter(_ sender: Any) {
//        count = count + 1
//        totalCountLabel.text = String(count)
//    }
    
}

