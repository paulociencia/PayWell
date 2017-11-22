//
//  Holding.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import Foundation

import UIKit
import SwiftyJSON

class Holding: NSObject {
    
    var holdingId:String
    var accountId:String
    
    var instrumentName:String
    var instrumentType:String
    var instrumentDescription:String
    
    var value:Double
    var price:Double
    var quantity:Int
    
    var prevValue:Double?
    var percentChange:Double?
    var netChange:Double?
    
    var lastUpdated:Double
    
    init(json:JSON) {
        self.holdingId = json["HOLDING_ID"].string!
        self.accountId = json["ACCOUNT_ID"].string!
        
        self.instrumentName = json["INSTRUMENT_NAME"].string!
        self.instrumentType = json["INSTRUMENT_TYPE"].string!
        self.instrumentDescription = json["INSTRUMENT_DESCRIPTION"].string!
        
        self.value = json["VALUE"].double!
        
        self.price = json["PRICE"].double!
        self.quantity = json["QUANTITY"].int!
        self.lastUpdated = json["LAST_UPDATED"].double!
        
        self.prevValue = json["PREV_VALUE"].double
        self.percentChange = json["PERCENT_CHANGE"].double
        self.netChange = json["NET_CHANGE"].double
        
    }
    
    func percentChangeColorAndText(label:UILabel) {
        guard let percentChange = self.percentChange else {
            return
        }
        
        var plusMinusSign = ""
        var percentColor = UIColor.black
        
        if (percentChange > 0.0) {
            percentColor = UIColor.init(red: 0, green: 190/255, blue: 0, alpha: 1)
            plusMinusSign = "+"
        } else if (percentChange < 0.0) {
            percentColor = UIColor.red
        }
        
        label.textColor = percentColor
        label.text = String(format: "%@%.02f%%", plusMinusSign, percentChange)
    }
}
