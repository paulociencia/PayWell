//
//  Appointment.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class Appointment : NSObject{
    var location:String;
    var subject:String;
    var status:String;
    var advisorName:String;
    var advisorEmail:String;
    var startDate:String;
    var endDate:String;
    
    init(json:JSON) {
        self.location = json["location"].string!;
        self.subject = json["subject"].string!
        self.status = json["status"].string!
        self.advisorName = json["advisor"]["name"].string!
        self.advisorEmail = json["advisor"]["email"].string!
        self.startDate = json["start"].string!
        self.endDate = json["end"].string!
    }
}
