//
//  LoginTableViewCell.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit

class LoginTableViewCell: UITableViewCell {

    @IBOutlet var itemImg: UIImageView!
    @IBOutlet var itemTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

