//
//  Alert.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import Foundation
import SwiftyJSON

class Alerts : NSObject {
    
    var alerts_id: String
    var alerts_type: AlertType
    var brief_description: String
    var entered_datetime: Date
    var title: String
    var user_acknowledged:Bool
    var user_id: String
    var weblink: String
    
    init(json:JSON) {
        
        let type:AlertType = AlertType( rawValue: json["ALERTS_TYPE"].string! )!
        let entered_datetime = Date(timeIntervalSince1970: ( json[ "ENTERED_DATETIME"].double! / 1000.0));
        
        self.alerts_id = json["ALERTS_ID"].string!
        self.alerts_type = type;
        self.brief_description = json["BRIEF_DESCRIPTION"].string!;
        self.entered_datetime = entered_datetime;
        self.title = json["TITLE"].string!;
        self.user_acknowledged = json["USER_ACKNOWLEDGED"].bool!;
        self.user_id = json["USER_ID"].string!;
        self.weblink = json["WEBLINK"].string!;
    }
    
    func whenAlertWasSent() -> String {
        let calendar = NSCalendar.current
        let date = self.entered_datetime
        if calendar.isDateInYesterday(date) { return "Yesterday" }
        else if calendar.isDateInToday(date) { return "Today" }
        else if calendar.isDateInTomorrow(date) { return "Tomorrow" }
        else {
            let startOfNow = calendar.startOfDay(for: Date())
            let startOfTimeStamp = calendar.startOfDay(for: date)
            let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
            let day = components.day!
            if day < 1 { return "\(abs(day)) days ago" }
            else { return "In \(day) days" }
        }
    }
}

enum AlertType: String {
    case HIGH, MEDIUM, LOW
}



