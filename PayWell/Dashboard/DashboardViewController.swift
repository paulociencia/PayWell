//
//  DashboardViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import Charts
import iCarousel
import NVActivityIndicatorView

enum HoldingsListType {
    case ByAccount,
    TopWinners,
    TopLosers,
    TopHoldings
}

class DashboardViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var lblPositions: UILabel!
    
    @IBOutlet weak var accountsLoadingIndicator: NVActivityIndicatorView!
    @IBOutlet weak var advisorsLoadingIndicator: NVActivityIndicatorView!
    @IBOutlet weak var topWinnerLoadingIndicator: NVActivityIndicatorView!
    @IBOutlet weak var alertsLoadingIndicator: NVActivityIndicatorView!
    
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var holdingsCarousel: iCarousel!
    @IBOutlet weak var advisorsCarousel: iCarousel!
    @IBOutlet weak var topWinnersCarousel: iCarousel!
    @IBOutlet weak var alertsCarousel: iCarousel!
    
    var items : NSMutableArray = NSMutableArray()
    var restAPIManager: RestAPIManager!
    var accountManager: AccountManager = AccountManager.sharedInstance
    var advisors: [Advisor] = []
    var todayWinners: [Holding] = []
    var todayLosers: [Holding] = []
    
    let blueColor = UIColor(red:0.00, green:0.29, blue:0.51, alpha:1.0)
    let pagingEnabled = true
    let scrollSpeed:CGFloat = 3.0
    let bounceDistance:CGFloat = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        summaryView.backgroundColor = UIColor.summaryView
        holdingsCarousel.isPagingEnabled = pagingEnabled
        advisorsCarousel.isPagingEnabled = pagingEnabled
        topWinnersCarousel.isPagingEnabled = pagingEnabled
        alertsCarousel.isPagingEnabled = pagingEnabled
        
        holdingsCarousel.scrollSpeed = scrollSpeed
        advisorsCarousel.scrollSpeed = scrollSpeed
        topWinnersCarousel.scrollSpeed = scrollSpeed
        alertsCarousel.scrollSpeed = scrollSpeed
        
        holdingsCarousel.bounceDistance = bounceDistance
        advisorsCarousel.bounceDistance = bounceDistance
        topWinnersCarousel.bounceDistance = bounceDistance
        alertsCarousel.bounceDistance = bounceDistance
        
        self.restAPIManager = RestAPIManager()
        
        populateDashboard()
        self.view.backgroundColor = UIColor.dashboardBg
    }
    
    func populateDashboard(){
        self.restAPIManager.accountSummary() { (value) in
            self.lblPositions.text = "\(value)"
        }
        
        self.accountsLoadingIndicator.startAnimating()
        self.advisorsLoadingIndicator.startAnimating()
        self.topWinnerLoadingIndicator.startAnimating()
        self.alertsLoadingIndicator.startAnimating()
        
        self.accountManager.requestAccounts { (accounts) in
            self.holdingsCarousel.reloadData()
            self.accountsLoadingIndicator.stopAnimating()
            self.holdingsCarousel.backgroundColor = UIColor.clear
        }
        
        self.restAPIManager.advisors { (advisors) in
            self.advisors = advisors
            self.advisorsCarousel.reloadData()
            self.advisorsLoadingIndicator.stopAnimating()
            self.advisorsCarousel.backgroundColor = UIColor.clear
        }
        
        self.restAPIManager.todayWinners { (winners) in
            self.todayWinners = winners
            
            self.restAPIManager.todayLosers { (losers) in
                self.todayLosers = losers
                
                self.topWinnerLoadingIndicator.stopAnimating()
                self.topWinnersCarousel.backgroundColor = UIColor.clear
                self.topWinnersCarousel.reloadData()
            }
        }
        
        self.alertsLoadingIndicator.stopAnimating()
        self.alertsCarousel.backgroundColor = UIColor.clear
        self.alertsCarousel.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "HoldingsDetailSegue") {
            self.prepareHoldingsViewController(segue: segue, listType: sender as! HoldingsListType)
        } else if (segue.identifier == "AdvisorsDetailSegue") {
            let advisorsDetailViewController:AdvisorViewController = segue.destination as! AdvisorViewController
            advisorsDetailViewController.navigationItem.leftBarButtonItem = nil
        } else if (segue.identifier == "NewsSegue") {
            let newsViewController:NewsViewController = segue.destination as! NewsViewController
            newsViewController.navigationItem.leftBarButtonItem = nil
        } else if (segue.identifier == "AlertsSegue") {
            let alertsViewController:AlertsViewController = segue.destination as! AlertsViewController
            alertsViewController.navigationItem.leftBarButtonItem = nil
        }
    }
    
    func prepareHoldingsViewController(segue: UIStoryboardSegue, listType: HoldingsListType) {
        let holdingsDetailViewController:HoldingsViewController = segue.destination as! HoldingsViewController
        
        switch listType {
        case .TopWinners:
            holdingsDetailViewController.accounts = [Account(name: "Top Winners", holdings: self.todayWinners)]
            print("TODAY WINNERS BOX")
            print(self.todayWinners)
        case .TopLosers:
            holdingsDetailViewController.accounts = [Account(name: "Top Losers", holdings: self.todayLosers)]
        case .TopHoldings:
            holdingsDetailViewController.accounts = self.accountManager.accounts
        default:
            holdingsDetailViewController.accounts = self.accountManager.accounts
        }
    }
}

extension DashboardViewController: iCarouselDelegate, iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        if (self.holdingsCarousel == nil) {
            return 0
        }
        
        switch carousel {
        case self.holdingsCarousel:
            return self.accountManager.accounts.count
        case self.topWinnersCarousel:
            return 3
        case self.alertsCarousel:
            return 3
        case self.advisorsCarousel:
            return self.advisors.count
        default:
            return 0
        }
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        switch carousel {
        case self.holdingsCarousel:
            return accountsCarouselView(view: view, index: index)
        case self.topWinnersCarousel:
            return topWinnersCarouselView(view: view, index: index)
        case self.alertsCarousel:
            return alertsCarouselView(view: view, index: index)
        case self.advisorsCarousel:
            return advisorCarouselView(view: view, index: index)
        default:
            return UIView()
        }
    }
    
    func carouselItemWidth(_ carousel: iCarousel) -> CGFloat {
        if (carousel == self.holdingsCarousel) {
            return self.holdingsCarousel.frame.size.width + 5
        } else {
            return self.advisorsCarousel.frame.size.width + 5
        }
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        switch carousel {
        case self.holdingsCarousel:
            performSegue(withIdentifier: "HoldingsDetailSegue", sender: HoldingsListType.ByAccount)
        case self.topWinnersCarousel:
            var listType:HoldingsListType;
            switch index {
            case 0:
                listType = HoldingsListType.TopWinners
            case 1:
                listType = HoldingsListType.TopLosers
            case 2:
                listType = HoldingsListType.TopHoldings
            default:
                listType = HoldingsListType.ByAccount
            }
            
            performSegue(withIdentifier: "HoldingsDetailSegue", sender: listType)
        case self.alertsCarousel:
            switch index {
            case 0:
                performSegue(withIdentifier: "AlertsSegue", sender: nil)
            case 1:
                performSegue(withIdentifier: "NewsSegue", sender: nil)
            case 2:
                performSegue(withIdentifier: "NewsSegue", sender: nil)
            default:
                print("alerts")
            }
        case self.advisorsCarousel:
            performSegue(withIdentifier: "AdvisorsDetailSegue", sender: nil)
        default:
            //todo
            print("default")
        }
    }
    
    func accountsCarouselView (view: UIView?, index: Int) -> UIView {
        var itemView: AccountCarouselView
        
        if let view = view {
            itemView = view as! AccountCarouselView
        } else {
            itemView = AccountCarouselView.instanceFromNib()
            itemView.frame = self.holdingsCarousel.frame
        }
        
        itemView.populateFromAccount(account: self.accountManager.accounts[index])
        return itemView
    }
    
    func topWinnersCarouselView(view: UIView?, index: Int) -> UIView {
        let viewFromNib = TopListView.instanceFromNib()
        var itemView: TopListView
        
        if let view = view {
            itemView = view as! TopListView
        } else {
            itemView = viewFromNib
            itemView.frame = self.topWinnersCarousel.frame
            itemView.layer.cornerRadius = self.topWinnersCarousel.layer.cornerRadius
        }
        
        switch index {
        case 0:
            itemView.populate(index: index, data: self.todayWinners)
        case 1:
            itemView.populate(index: index, data: self.todayLosers)
        case 2:
            itemView.populate(index: index, data: [])
        default:
            print("Top Winners and Losers")
        }
        
        let borderColor = UIColor.lightGray.withAlphaComponent(0.6)
        
        itemView.layer.borderColor = borderColor.cgColor
        itemView.layer.borderWidth = 0.5
        
        return itemView
    }
    
    func alertsCarouselView(view: UIView?, index: Int) -> UIView {
        let viewFromNib = LatestAlertsCarouselView.instanceFromNib()
        var itemView: LatestAlertsCarouselView
        
        if let view = view {
            itemView = view as! LatestAlertsCarouselView
        } else {
            itemView = viewFromNib
            itemView.frame = self.alertsCarousel.frame
            itemView.layer.cornerRadius = self.alertsCarousel.layer.cornerRadius
        }
        
        itemView.populate(index: index)
        
        let borderColor = UIColor.lightGray.withAlphaComponent(0.6)
        
        itemView.layer.borderColor = borderColor.cgColor
        itemView.layer.borderWidth = 0.5
        
        return itemView
    }
    
    func advisorCarouselView(view: UIView?, index: Int) -> UIView {
        let viewFromNib = AdvisorCarouselView.instanceFromNib()
        var itemView: AdvisorCarouselView
        
        if let view = view {
            itemView = view as! AdvisorCarouselView
        } else {
            itemView = viewFromNib
            itemView.frame = self.advisorsCarousel.frame
            itemView.layer.cornerRadius = self.advisorsCarousel.layer.cornerRadius
        }
        
        itemView.populateFromAdvisor(advisor: self.advisors[index])
        
        return itemView
    }
}
