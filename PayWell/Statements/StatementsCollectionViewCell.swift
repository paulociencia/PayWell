//
//  StatementsCollectionViewCell.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit

class StatementsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var statementTitleLabel: UILabel!
    @IBOutlet weak var statementDateLabel: UILabel!
    @IBOutlet weak var statementDownloadButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

