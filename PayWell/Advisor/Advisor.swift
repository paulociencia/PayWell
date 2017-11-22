//
//  Advisor.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


class Advisor : NSObject {
    var address_line1:String;
    var address_line2:String;
    var address_line3:String;
    var website:String;
    var country:String;
    var city:String;
    var state:String;
    var postal_code:String;
    
    var title:String;
    var social_linkedin:String;
    var social_twitter:String;
    var telephone_number_direct:String;
    var telephone_number_office:String;
    var telephone_number_mobile:String;
    
    var client_advisor_mapping_id:String;
    var advisor_id:String;
    var user_type:String;
    var finra_crd_id:String;
    var client_id:String;
    var email:String!
    var firstName:String!
    var lastName:String!
    
    init(json:JSON) {
        
        self.address_line1 = json["ADDRESS_LINE1"].string!
        self.address_line2 = json["ADDRESS_LINE2"].string!
        self.address_line3 = json["ADDRESS_LINE3"].string!
        self.website = json["WEBSITE"].string!
        self.country = json["COUNTRY"].string!
        self.city = json["CITY"].string!
        self.state = json["STATE"].string!
        self.postal_code = json["POSTAL_CODE"].string!
        self.title = json["TITLE"].string!
        self.social_linkedin = json["LINKED_IN_PROFILE"].string!
        self.social_twitter = json["TWITTER_PROFILE"].string!
        self.telephone_number_direct = json["TELEPHONE_NUMBER_DIRECT"].string!
        self.telephone_number_office = json["TELEPHONE_NUMBER_OFFICE"].string!
        self.telephone_number_mobile = json["MOBILE_NUMBER"].string!
        
        self.client_advisor_mapping_id = json["CLIENT_ADVISOR_MAPPING_ID"].string!
        self.advisor_id = json["ADVISOR_ID"].string!
        self.user_type = json["USER_TYPE"].string!
        self.finra_crd_id = json["FINRA_CRD_ID"].string!
        self.client_id = json["CLIENT_ID"].string!
        self.email = json["EMAIL_ADDRESS"].string!
        self.firstName = json["FIRST_NAME"].string!
        self.lastName = json["LAST_NAME"].string!
    }
    
}

