//
//  News.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class News : NSObject {
    
    var brief_description:String;
    var news_id:String;
    var user_id:String;
    var title:String;
    var news_type:String;
    var weblink:String;
    var user_acknowledge:Bool;
    
    init(json:JSON) {
        
        self.brief_description =  json["BRIEF_DESCRIPTION"].string!
        self.news_id = json["NEWS_ID"].string!
        self.user_id = json["USER_ID"].string!
        self.title = json["TITLE"].string!
        self.news_type = json["NEWS_TYPE"].string!
        self.weblink = json["WEBLINK"].string!
        self.user_acknowledge = json["USER_ACKNOWLEDGED"].bool!
    }
}
