//
//  AnnouncementsViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import Foundation
import NVActivityIndicatorView

class AnnouncementsViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var announcementsTableView: UITableView!
    var announcementsData:[Announcements] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAnnouncements()
        announcementsTableView.tableFooterView = UIView()
    }
    
    func loadAnnouncements(){
        self.activityIndicatorView.color = UIColor(red:0.00, green:0.29, blue:0.51, alpha:1.0)
        self.activityIndicatorView.startAnimating()
        
        let restAPIManager = RestAPIManager()
        
        restAPIManager.announcements() {(result) in
            self.announcementsData = result;
            self.announcementsTableView.reloadData()
            self.activityIndicatorView.stopAnimating()
        }
    }
}

extension AnnouncementsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.announcementsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell( withIdentifier:"announcementsCell", for: indexPath)
        let announcement = self.announcementsData[indexPath.row]
        
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        cell.textLabel?.text = announcement.title
        
        cell.detailTextLabel?.numberOfLines = 3
        cell.detailTextLabel?.text = announcement.brief_description
        
        // not applying to the first item, only for demonstrating the different states
        // TODO: Remove it later
        if ( announcement.user_acknowledged && indexPath.row != 0) {
            cell.textLabel?.textColor = UIColor.gray
            cell.detailTextLabel?.textColor = UIColor.gray
        }
        
        return cell
    }
    
    
}


