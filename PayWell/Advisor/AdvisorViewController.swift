//
//  AdvisorViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import iCarousel
import NVActivityIndicatorView

class AdvisorViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var advisorsFullCarousel: iCarousel!
    
    var advisors: [Advisor] = []
    var restAPIManager: RestAPIManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        advisorsFullCarousel.isPagingEnabled = true
        advisorsFullCarousel.scrollSpeed = 3
        advisorsFullCarousel.bounceDistance = 0.3
        
        self.restAPIManager = RestAPIManager()
        self.populateAdvisors()
    }
    
    func populateAdvisors() {
        self.activityIndicatorView.color = UIColor(red:0.00, green:0.29, blue:0.51, alpha:1.0)
        self.activityIndicatorView.startAnimating()
        self.restAPIManager.advisors { (advisors) in
            self.advisors = advisors
            self.advisorsFullCarousel.reloadData()
            self.activityIndicatorView.stopAnimating()
        }
    }
}

extension AdvisorViewController: iCarouselDelegate, iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return self.advisors.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let viewFromNib = AdvisorFullCarouselView.instanceFromNib()
        var itemView: AdvisorFullCarouselView
        
        if let view = view {
            itemView = view as! AdvisorFullCarouselView
        } else {
            itemView = viewFromNib
            itemView.frame = self.advisorsFullCarousel.frame
        }
        
        itemView.populateFromAdvisor(advisor: self.advisors[index])
        
        return itemView
        
    }
    
    func carouselItemWidth(_ carousel: iCarousel) -> CGFloat {
        return self.advisorsFullCarousel.frame.size.width + 10
    }
}
