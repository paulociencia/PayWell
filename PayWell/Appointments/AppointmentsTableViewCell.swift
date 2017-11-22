//
//  AppointmentsTableViewCell.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit

class AppointmentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weekday: UILabel!
    @IBOutlet weak var mainStartTime: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var timeRange: UILabel!
    @IBOutlet weak var advisor: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var period: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
