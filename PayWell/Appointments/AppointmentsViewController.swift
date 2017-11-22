//
//  AppointmentsViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class AppointmentsViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var appointmentsTableView: UITableView!
    var appointmentsData:[Appointment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAppointments()
        appointmentsTableView.tableFooterView = UIView()
    }
    
    func loadAppointments(){
        let restAPIManager = RestAPIManager()
        
        self.activityIndicatorView.color = UIColor(red:0.00, green:0.29, blue:0.51, alpha:1.0)
        self.activityIndicatorView.startAnimating()
        
        restAPIManager.appointments() {(result) in
            self.appointmentsData = result;
            self.appointmentsTableView.reloadData()
            self.activityIndicatorView.stopAnimating()
        }
    }
}

extension AppointmentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appointmentsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"appointmentCell", for: indexPath) as! AppointmentsTableViewCell
        let appointment:Appointment = self.appointmentsData[indexPath.row]
        
        cell.subject.text = appointment.subject
        cell.advisor.text = String(format: "Advisor: %@", appointment.advisorName)
        cell.location.text = String(format: "Location: %@", appointment.location)
        
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzzzzzz"
        isoFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = isoFormatter.date(from: appointment.startDate) {
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "hh:mm"
            cell.mainStartTime.text = dateFormatter.string(from: date)
            
            dateFormatter.dateFormat = "EEE, MMM dd"
            cell.weekday.text = dateFormatter.string(from: date)
            
            dateFormatter.dateFormat = "a"
            cell.period.text = dateFormatter.string(from: date)
            
            if let endDate = isoFormatter.date(from: appointment.endDate) {
                dateFormatter.dateFormat = "hh:mm a"
                let startDateString = dateFormatter.string(from: date)
                let endDateString = dateFormatter.string(from: endDate)
                
                cell.timeRange.text = String(format: "%@ - %@", startDateString, endDateString)
            }
        }
        
        return cell
    }
}

