//
//  Notifications.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import Foundation
import SwiftyJSON

class Notification: NSObject {
    
    var notificationId:String
    var clientId:String
    var userId:String
    var notificationText:String
    var userAcknowledge:Bool
    var notificationType:String
    
    init(json:JSON) {
        self.notificationId = json["NOTIFICATION_ID"].string!
        self.clientId = json["CLIENT_ID"].string!
        self.userId = json["USER_ID"].string!
        self.notificationText = json["NOTIFICATION_TEXT"].string!
        self.userAcknowledge = json["USER_ACKNOWLEDGED"].bool!
        
        self.notificationType = json["NOTIFICATION_TYPE"].string!
        
    }
    
}
