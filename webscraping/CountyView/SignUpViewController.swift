//
//  SignUpViewController.swift
//  webscraping
//
//  Created by Brandon Pham on 7/20/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var signLabel: UILabel!
    
    override func viewDidLoad() {
        signLabel.sizeToFit()
        signButton.sizeToFit()
        view.layoutIfNeeded()
        hideKeyboardWhenTappedAround()
        self.userEmail.becomeFirstResponder() 
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {

        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"

        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))

            if results.count == 0
            {
                returnValue = false
            }

        }// let error -> _
        catch _ as NSError {
            print("invalid regex: (error.localizedDescription)")
            returnValue = false
        }

        return  returnValue
    }
    
    
    @IBOutlet weak var userEmail: UITextField!
    
    @IBAction func addtoDB(_ sender: Any) {
        let db = Firestore.firestore()
        let valid = isValidEmailAddress(emailAddressString: userEmail.text ?? "")

        if valid {
            db.collection("emails").document("addresses").updateData(["emails": FieldValue.arrayUnion([userEmail.text ?? ""])])
            let alert = UIAlertController(title: "Success", message: "Email was added!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message: "Not a valid email!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    

}
