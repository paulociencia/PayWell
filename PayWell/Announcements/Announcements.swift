//
//  Announcements.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class Announcements : NSObject {
    
    var announcement_id:String
    var announcement_type:AnnouncementType;
    var brief_description:String
    var entered_datetime:Date
    var title:String;
    var user_acknowledged:Bool;
    var user_id:String;
    var weblink:String;
    
    init(json:JSON) {
        
        let type = AnnouncementType( rawValue: json["ANNOUNCEMENT_TYPE"].string! )!
        let entered_datetime = Date(timeIntervalSince1970: ( json["ENTERED_DATETIME"].double! / 1000.0));
        
        self.announcement_id = json["ANNOUNCEMENT_ID"].string!
        self.announcement_type = type;
        self.brief_description = json["BRIEF_DESCRIPTION"].string!
        self.entered_datetime = entered_datetime;
        self.title = json["TITLE"].string!;
        self.user_id = json["USER_ID"].string!;
        self.user_acknowledged = json["USER_ACKNOWLEDGED"].bool!;
        self.weblink = json["WEBLINK"].string!;
        
    }
}

enum AnnouncementType: String {
    case CORPORATE, TECHNICAL, ADVISOR
}

