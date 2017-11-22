//
//  HoldingsViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HoldingsViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var holdingsTableView: UITableView!
    
    var accounts:[Account] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "HoldingsTableViewHeader", bundle: nil)
        self.holdingsTableView.register(nib, forHeaderFooterViewReuseIdentifier: "HoldingsTableViewHeader")
        
        if (self.accounts.count == 0) {
            self.accounts = AccountManager.sharedInstance.accounts
        } else {
            self.navigationItem.leftBarButtonItem = nil
        }
        
        self.holdingsTableView.tableFooterView = UIView()
        self.holdingsTableView.reloadData()
    }
}

extension HoldingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (accounts.count > 0) {
            return accounts[section].holdings.count
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (accounts.count > 0) {
            return accounts[section].name
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = accounts[section].name
        
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HoldingsTableViewHeader")
        let header:HoldingsTableViewHeader = cell as! HoldingsTableViewHeader
        header.titleSectionLabel.text = title
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let account:Account = self.accounts[indexPath.section]
        let item:Holding = account.holdings[indexPath.row]
        let cell:HoldingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "holdingCell") as! HoldingTableViewCell
        
        cell.contentView.subviews[0].layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        cell.contentView.subviews[0].layer.borderWidth = 0.5
        
        cell.name.text = item.instrumentDescription
        cell.holdingValue.text = item.value.currencyFormatter()
        cell.type.text = String(format: "%@ (%@)", item.instrumentType, item.instrumentName)
        item.percentChangeColorAndText(label: cell.percentageChange)
        return cell
    }
}

