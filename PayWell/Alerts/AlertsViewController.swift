//
//  AlertsViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import FontAwesomeKit
import NVActivityIndicatorView

class AlertsViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var alertsTableView: UITableView!
    var alertsData:[Alerts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAlerts()
        alertsTableView.tableFooterView = UIView()
    }
    
    func loadAlerts(){
        self.activityIndicatorView.color = UIColor(red:0.00, green:0.29, blue:0.51, alpha:1.0)
        self.activityIndicatorView.startAnimating()
        
        let restAPIManager = RestAPIManager()
        
        restAPIManager.alerts() {(result) in
            self.alertsData = result;
            self.alertsTableView.reloadData()
            self.activityIndicatorView.stopAnimating()
        }
    }
}

extension AlertsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.alertsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell( withIdentifier:"alertsCell", for: indexPath) as! AlertsTableViewCell
        let alert = self.alertsData[indexPath.row]
        
        let circleIcon:FAKIcon = FAKFontAwesome.circleIcon(withSize: 10)
        let circleIconImage:UIImage = circleIcon.image(with: CGSize(width: 10, height: 10))
        
        cell.alertIcon.setImage(circleIconImage, for: UIControlState.normal)
        
        switch alert.alerts_type {
        case AlertType.HIGH:
            cell.alertIcon.tintColor = UIColor.red
        case AlertType.MEDIUM:
            cell.alertIcon.tintColor = UIColor.orange
        case AlertType.LOW:
            cell.alertIcon.tintColor = UIColor.blue
        }
        
        cell.alertTitle.text = alert.title
        
        cell.alertDescription.numberOfLines = 2
        cell.alertDescription.text = alert.brief_description
        
        
        let calendarIcon:FAKIcon = FAKFontAwesome.calendarIcon(withSize: 10)
        let calendarIconImage:UIImage = calendarIcon.image(with: CGSize(width: 10, height: 10))
        cell.alertDateIcon.setImage(calendarIconImage, for: UIControlState.normal)
        cell.alertDate.text = alert.whenAlertWasSent()
        // not applying to the first item, only for demonstrating the different states
        // TODO: Remove it later
        if ( alert.user_acknowledged && indexPath.row != 0) {
            cell.alertTitle.textColor = UIColor.gray
            cell.alertDescription.textColor = UIColor.gray
        }
        
        return cell
    }
}
