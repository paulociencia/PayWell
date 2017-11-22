//
//  TopListView.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import FontAwesomeKit

class TopListView: UIView {
    
    @IBOutlet weak var cardTitle: UILabel!
    
    @IBOutlet weak var iconTitle: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var title3: UILabel!
    
    @IBOutlet weak var holdingValue: UILabel!
    @IBOutlet weak var holdingValue2: UILabel!
    @IBOutlet weak var holdingValue3: UILabel!
    
    @IBOutlet weak var percentChange: UILabel!
    @IBOutlet weak var percentChange2: UILabel!
    @IBOutlet weak var percentChange3: UILabel!
    
    class func instanceFromNib() -> TopListView {
        return UINib(nibName: "TopListView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TopListView
    }
    
    func populate(index: Int, data: [Holding]) {
        var icon:FAKIcon
        
        switch index {
        case 0:
            self.cardTitle.text = "Top Winners"
            icon = FAKFontAwesome.arrowUpIcon(withSize: 12)
        case 1:
            self.cardTitle.text = "Top Losers"
            self.populateLosersFields(data: data)
            icon = FAKFontAwesome.arrowDownIcon(withSize: 12)
        case 2:
            self.cardTitle.text = "Top Holdings"
            icon = FAKFontAwesome.starIcon(withSize: 12)
        default:
            self.cardTitle.text = ""
            icon = FAKFontAwesome.lineChartIcon(withSize: 12)
        }
        
        let width = 10
        var height = 10
        if (index == 2) {
            height = 12
        }
        
        icon.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGray)
        self.iconTitle.image = icon.image(with: CGSize(width: width, height: height))
    }
    
    func populateLosersFields(data: [Holding?]) {
        if 0 < data.count {
            let holding = data[0]!
            self.title.text = holding.instrumentDescription + "(" + holding.instrumentName + ")"
            self.holdingValue.text = holding.value.currencyFormatter()
            holding.percentChangeColorAndText(label: self.percentChange)
        }
        
        if 1 < data.count {
            let holding = data[1]!
            self.title2.text = holding.instrumentDescription + "(" + holding.instrumentName + ")"
            self.holdingValue2.text = holding.value.currencyFormatter()
            holding.percentChangeColorAndText(label: self.percentChange2)
        }
        
        if 2 < data.count {
            let holding = data[2]!
            self.title3.text = holding.instrumentDescription + "(" + holding.instrumentName + ")"
            self.holdingValue3.text = holding.value.currencyFormatter()
            holding.percentChangeColorAndText(label: self.percentChange3)
        }
    }
}

