//
//  BrokerageViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import Foundation
import FontAwesomeKit

class BrokerageViewController: StatementsBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func populateCollectionCell(cell: StatementsCollectionViewCell, indexPath: IndexPath) -> StatementsCollectionViewCell {
        cell.contentView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        cell.contentView.layer.borderWidth = 0.5
        
        cell.statementTitleLabel.text = "November Brokerage"
        cell.statementDateLabel.text = "11/2017"
        
        let downloadIcon:FAKIcon = FAKFontAwesome.downloadIcon(withSize: 25)
        let downloadIconImage:UIImage = downloadIcon.image(with: CGSize(width: 25, height: 25))
        cell.statementDownloadButton.setImage(downloadIconImage, for: UIControlState.normal)
        
        
        return cell
    }
}

