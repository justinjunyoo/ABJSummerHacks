//
//  FirebaseViewController.swift
//  webscraping
//
//  Created by Aarish  Brohi on 6/26/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore


class FirebaseViewController: UIViewController {
    
//    var db: Firestore!
    var data = DataNumbers(nibName: nil, bundle: nil).allInfo()
    var countyCollection : CollectionReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData()  {
        let db = Firestore.firestore()
        for i in 0...data.count-1{
            db.collection("Counties").document("\(data[i].name)").setData([
                "Name": "\(data[i].name)",
                "Cases": Int(data[i].cases),
                "Deaths": Int(data[i].deaths)
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    }
    
    func readData(){
        countyCollection.getDocuments { (snapshot, error) in
            if let err = error{
                debugPrint("Error: \(err)")
            }
            else{
                guard let snap = snapshot else {return}
                for documents in snap.documents{
                    print(documents["Name"] as? String ?? "")
                }
            }
        }
    }


}
