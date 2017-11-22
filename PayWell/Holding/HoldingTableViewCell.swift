//
//  HoldingTableViewCell.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit

class HoldingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var holdingValue: UILabel!
    @IBOutlet weak var percentageChange: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

