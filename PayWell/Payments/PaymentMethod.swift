//
//  File.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import Foundation

class PaymentManager {
     static var paymentsMethod:[PaymentMethod] = []
}

class PaymentMethod {
    
    var id:String
    var name:String
    var isDefault:Bool
    var image:UIImage
    var type:PaymentMethodType
    
    init(name:String, type:PaymentMethodType, image:UIImage, isDefault:Bool) {
        self.id = UUID().uuidString
        self.name = name
        self.type = type
        self.image = image
        self.isDefault = isDefault
    }
}

enum PaymentMethodType: String {
    case CREDIT_CARD, PAYPAL, CASH, PAY_WITH_GOOGLE, BIT_COIN
}

class CreditCard :PaymentMethod {
    
    var number:String
    var validTill:String
    var cvv:Int
    var zipCode:String
    
    init(name:String, type:PaymentMethodType, image:UIImage, isDefault:Bool, number:String, validTill:String, cvv:Int, zipcode:String) {
        self.number = number
        self.validTill = validTill
        self.cvv = cvv
        self.zipCode = zipcode
        
        super.init(name: name, type: type, image: image, isDefault: isDefault)
        
    }
    
}


