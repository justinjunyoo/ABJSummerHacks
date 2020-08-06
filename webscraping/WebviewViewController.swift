//
//  WebviewViewController.swift
//  webscraping
//
//  Created by Aarish  Brohi on 6/17/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import WebKit
import MessageUI
import Social

class WebviewViewController: UIViewController, WKNavigationDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {

    
    @IBOutlet weak var webView: WKWebView!
    var url: String?
    
    

    
    @IBAction func returnNews(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func loadView() {
        super.loadView()
        webView.navigationDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: URL(string: url!)!))
        webView.allowsBackForwardNavigationGestures = true
    }

    @IBAction func shareSMS(_ sender: Any) {
        if(MFMessageComposeViewController.canSendText()){
            let message: MFMessageComposeViewController = MFMessageComposeViewController()
            message.messageComposeDelegate  = self
            message.recipients = nil
            message.body = (url!)
            self.present(message, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Warning", message: "This device can not send SMS message.", preferredStyle: UIAlertController.Style.alert)
                           
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                           
            self.present(alert, animated: true, completion: nil)
        }
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
        
        

    @IBAction func shareEmail(_ sender: Any) {
        if MFMailComposeViewController.canSendMail(){
            let mail:MFMailComposeViewController = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(nil)
            mail.setSubject("Check it out")
            mail.setMessageBody(url!, isHTML: true)
            self.present(mail, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Accounts", message: "Please login to an Email account to send.", preferredStyle: UIAlertController.Style.alert)
                               
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                               
            self.present(alert, animated: true, completion: nil)
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
}
