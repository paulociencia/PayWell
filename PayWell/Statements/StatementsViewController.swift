//
//  StatementsViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import Foundation
import UIKit
import FontAwesomeKit

class StatementsViewController: UITabBarController {
    
    @IBOutlet weak var statementsTabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let handshakeIcon:FAKIcon = FAKFontAwesome.handshakeOIcon(withSize: 20)
        let handshakeIconImage:UIImage = handshakeIcon.image(with: CGSize(width: 20, height: 20))
        self.tabBar.items![0].image = handshakeIconImage
        
        let calendarIcon:FAKIcon = FAKFontAwesome.calendarIcon(withSize: 20)
        let calendarIconImage:UIImage = calendarIcon.image(with: CGSize(width: 20, height: 20))
        self.tabBar.items![1].image = calendarIconImage
        
        let moneyIcon:FAKIcon = FAKFontAwesome.moneyIcon(withSize: 20)
        let moneyIconImage:UIImage = moneyIcon.image(with: CGSize(width: 20, height: 20))
        self.tabBar.items![2].image = moneyIconImage
        
        let briefcaseIcon:FAKIcon = FAKFontAwesome.briefcaseIcon(withSize: 20)
        let briefcaseIconImage:UIImage = briefcaseIcon.image(with: CGSize(width: 20, height: 20))
        self.tabBar.items![3].image = briefcaseIconImage
    }
    
}
