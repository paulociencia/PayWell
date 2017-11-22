//
//  Account.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import Foundation
import SwiftyJSON

class Account: NSObject {
    
    var userId:String?
    var accountId:String?
    
    var taxable:Bool?
    var accountHolding:Double?
    var accountHoldingPriorClose:Double?
    var percentChange:Double?
    var type:String?
    var name:String?
    
    var lastUpdated:Double?
    
    var holdings:[Holding]
    
    init(json:JSON) {
        self.userId = json["USER_ID"].string!
        self.accountId = json["ACCOUNT_ID"].string!
        
        self.taxable = json["TAXABLE"].bool!
        self.accountHolding = json["ACCOUNT_HOLDING"].double!
        if let accountHoldingPriorClose = json["ACCOUNTING_HOLDING_PRIOR_CLOSE"].double {
            self.accountHoldingPriorClose = accountHoldingPriorClose
        }
        else {
           self.accountHoldingPriorClose = 0.0
        }
        
        if let percentChange = json["PERCENT_CHANGE"].double {
            self.percentChange = percentChange
        }
        else {
            self.percentChange = 100.0
        }
        
        self.type = json["ACCOUNT_TYPE"].string!
        self.name = json["ACCOUNT_NAME"].string!
        
        self.lastUpdated = json["ACCOUNT_LAST_UPDATED"].double!
        self.holdings = []
    }
    
    init(name: String, holdings:[Holding]) {
        self.name = name
        self.holdings = holdings
    }
    
    func percentChangeColorAndText(label: UILabel) {
        var plusMinusSign = ""
        var percentColor = UIColor.red
        
        if let percentChange = self.percentChange {
            if (percentChange > 0) {
                percentColor = UIColor.init(red: 0, green: 190/255, blue: 0, alpha: 1)
                plusMinusSign = "+"
            }
            
            label.textColor = percentColor
            label.text = String(format: "%@%.02f%%", plusMinusSign, percentChange)
        }
    }
}


