//
//  UIColor+Custom.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit

extension UIColor {
    static let mainColor = UIColor.init(red: 0, green: 74, blue: 129)
    static let secundaryColor = UIColor.init(red: 110, green: 182, blue: 218)
    static let thirdColor = UIColor.init(red: 19, green: 41, blue: 77)
    
    static let leftMenuBg = UIColor.thirdColor
    static let leftMenuSelection = UIColor.secundaryColor
    
    static let loginBg = UIColor.mainColor
    static let loginButtonBg = UIColor.secundaryColor
    static let loginButtonText = UIColor.white
    
    static let dashboardBg = UIColor.init(red: 238, green: 240, blue: 245)
    static let summaryView = UIColor.mainColor
    
    static let navigationBg = UIColor.mainColor
    static let navigationText = UIColor.white
    
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}

