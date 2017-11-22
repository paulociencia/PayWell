//
//  NewsViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class NewsViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var newsTableView: UITableView!
    var newsData:[News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNews()
        newsTableView.tableFooterView = UIView()
    }
    
    func loadNews(){
        self.activityIndicatorView.color = UIColor(red:0.00, green:0.29, blue:0.51, alpha:1.0)
        self.activityIndicatorView.startAnimating()
        
        let restAPIManager = RestAPIManager()
        
        restAPIManager.news() {(result) in
            self.newsData = result;
            self.newsTableView.reloadData()
            self.activityIndicatorView.stopAnimating()
        }
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"newsCell", for: indexPath)
        let news:News = self.newsData[indexPath.row]
        
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        cell.textLabel?.text = news.title
        
        cell.detailTextLabel?.numberOfLines = 3
        cell.detailTextLabel?.text = news.brief_description
        
        if (news.user_acknowledge) {
            cell.textLabel?.textColor = UIColor.gray
            cell.detailTextLabel?.textColor = UIColor.gray
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "NewsWebViewSegue") {
            let viewController:WebViewViewController = segue.destination as! WebViewViewController
            viewController.url = self.newsData[self.newsTableView.indexPathForSelectedRow!.row].weblink
        }
    }
}

