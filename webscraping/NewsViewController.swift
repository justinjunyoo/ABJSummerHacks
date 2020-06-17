//
//  NewsViewController.swift
//  webscraping
//
//  Created by Aarish  Brohi on 6/17/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import WebKit
import Kingfisher

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var articles:[Article]? = []
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        fetchArticles()
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func fetchArticles(){
        let urlRequest = URLRequest(url: URL(string: "http://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=0f5b02df04cb45a3bf63abc9d522d192")!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            self.articles = [Article]()
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                if let articlesFromJSon = json["articles"] as? [(AnyObject)]{
                    for articlesFromJSon in articlesFromJSon{
                        let article = Article()
                        if let title = articlesFromJSon["title"] as? String, let desc = articlesFromJSon["description"] as? String, let author = articlesFromJSon["author"] as? String, let url = articlesFromJSon["url"] as? String, let urlToImage = articlesFromJSon["urlToImage"] as? String{
                            
                            article.title = title
                            article.desc = desc
                            article.author = author
                            article.url = url
                            article.image = urlToImage
                            
                            self.articles?.append(article)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch let err{
                print(err)
            }
            
        }
        task.resume()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        cell.title.text = self.articles?[indexPath.row].title
        cell.author.text = self.articles?[indexPath.row].author
        cell.desc.text = self.articles?[indexPath.row].desc
        cell.imgView?.downloadImage(from: (self.articles?[indexPath.row].image)!)
//        cell.imageView?.frame = CGRect(x: 8, y: 8, width: 100, height: 100)
        
        
//        let resource = ImageResource(downloadURL: URL(string: (self.articles?[indexPath.row].url)!)!, cacheKey: self.articles?[indexPath.row].url);
        let resource = URL(string: (self.articles?[indexPath.row].url)!)!
        cell.imgView.kf.setImage(with: resource)
        
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let wbView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebviewViewController
        wbView.url = self.articles?[indexPath.row].url
        wbView.modalPresentationStyle = .fullScreen
        self.present(wbView, animated: true, completion: nil)
    }
    
}

extension UIImageView{
    func downloadImage(from url: String){
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest)  { (data, _, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}



