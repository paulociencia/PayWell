//
//  AccountCarouselView.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//
import UIKit

class AccountCarouselView: UIView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var holdingValue: UILabel!
    @IBOutlet weak var holdingsCount: UILabel!
    @IBOutlet weak var accountType: UILabel!
    
    @IBOutlet weak var percentChange: UILabel!
    
    class func instanceFromNib() -> AccountCarouselView {
        return UINib(nibName: "AccountCarouselView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AccountCarouselView
    }
    
    func populateFromAccount(account:Account) {
        let borderColor = UIColor.lightGray.withAlphaComponent(0.6)
        
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 0.5
        
        self.title.text = account.name
        self.holdingValue.text = account.accountHolding?.currencyFormatter()
        var holdingString = "holding"
        
        if (account.holdings.count > 1) {
            holdingString += "s"
        }
        
        account.percentChangeColorAndText(label: self.percentChange)
        
        self.holdingsCount.text = String(format: "%d %@", account.holdings.count, holdingString)
        self.accountType.text = account.type
    }
}

