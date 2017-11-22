//
//  LatestAlertsCarouselView.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import FontAwesomeKit

class LatestAlertsCarouselView: UIView {
    
    @IBOutlet weak var titleIcon: UIButton!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var firstItemIcon: UIButton!
    @IBOutlet weak var firstItemLabel: UILabel!
    
    @IBOutlet weak var secondItemIcon: UIButton!
    @IBOutlet weak var secondItemLabel: UILabel!
    
    @IBOutlet weak var thirdItemIcon: UIButton!
    @IBOutlet weak var thirdItemLabel: UILabel!
    
    class func instanceFromNib() -> LatestAlertsCarouselView {
        return UINib(nibName: "LatestAlertsCarouselView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LatestAlertsCarouselView
    }
    
    func populate(index: Int) {
        switch index {
        case 0:
            let bellIcon:FAKIcon = FAKFontAwesome.bellIcon(withSize: 12)
            let bellIconimage:UIImage = bellIcon.image(with: CGSize(width: 12, height: 12))
            self.titleIcon.setImage(bellIconimage, for: UIControlState.normal)
            self.title.text = "Alerts"
            
            let circleIcon:FAKIcon = FAKFontAwesome.circleIcon(withSize: 10)
            let circleIconImage:UIImage = circleIcon.image(with: CGSize(width: 10, height: 10))
            
            self.firstItemIcon.setImage(circleIconImage, for: UIControlState.normal)
            self.firstItemIcon.tintColor = UIColor.red
            self.firstItemLabel.text = "Operational Support Portal Available!"
            
            self.secondItemIcon.setImage(circleIconImage, for: UIControlState.normal)
            self.secondItemIcon.tintColor = UIColor.orange
            self.secondItemLabel.text = "Upload latest tax document"
            
            self.thirdItemIcon.setImage(circleIconImage, for: UIControlState.normal)
            self.thirdItemIcon.tintColor = UIColor.red
            self.thirdItemLabel.text = "Advait uploaded tax document"
        case 1:
            let newsIcon:FAKIcon = FAKFontAwesome.newspaperOIcon(withSize: 12)
            let newsIconimage:UIImage = newsIcon.image(with: CGSize(width: 12, height: 12))
            self.titleIcon.setImage(newsIconimage, for: UIControlState.normal)
            self.title.text = "News"
            
            let dotcircleIcon:FAKIcon = FAKFontAwesome.dotCircleOIcon(withSize: 10)
            let dotcircleIconimage:UIImage = dotcircleIcon.image(with: CGSize(width: 10, height: 10))
            
            self.firstItemIcon.setImage(dotcircleIconimage, for: UIControlState.normal)
            self.firstItemLabel.text = "Microsoft generated approximately 90 billion U.S. dollars in revenue"
            
            self.secondItemIcon.setImage(dotcircleIconimage, for: UIControlState.normal)
            self.secondItemLabel.text = "New News on AssetMark"
            
            let globeIcon:FAKIcon = FAKFontAwesome.globeIcon(withSize: 10)
            let globeIconimage:UIImage = globeIcon.image(with: CGSize(width: 10, height: 10))
            
            self.thirdItemIcon.setImage(globeIconimage, for: UIControlState.normal)
            self.thirdItemLabel.text = "Tesla announces new energy plant"
            
        case 2:
            let researchIcon:FAKIcon = FAKFontAwesome.lightbulbOIcon(withSize: 12)
            let researchIconimage:UIImage = researchIcon.image(with: CGSize(width: 12, height: 12))
            self.titleIcon.setImage(researchIconimage, for: UIControlState.normal)
            self.title.text = "Research"
            
            let globeIcon:FAKIcon = FAKFontAwesome.globeIcon(withSize: 10)
            let globeIconimage:UIImage = globeIcon.image(with: CGSize(width: 10, height: 10))
            
            self.firstItemIcon.setImage(globeIconimage, for: UIControlState.normal)
            self.firstItemLabel.text = "Opportunity in Consumer Staples"
            
            let dotcircleIcon:FAKIcon = FAKFontAwesome.dotCircleOIcon(withSize: 10)
            let dotcircleIconimage:UIImage = dotcircleIcon.image(with: CGSize(width: 10, height: 10))
            
            self.secondItemIcon.setImage(dotcircleIconimage, for: UIControlState.normal)
            self.secondItemLabel.text = "Tesla new energy battery revealed..."
            
            self.thirdItemIcon.isHidden = true
            self.thirdItemLabel.text = ""
            
        case 3:
            let announcementsIcon:FAKIcon = FAKFontAwesome.bullhornIcon(withSize: 12)
            let announcementsIconimage:UIImage = announcementsIcon.image(with: CGSize(width: 12, height: 12))
            self.titleIcon.setImage(announcementsIconimage, for: UIControlState.normal)
            self.title.text = "Announcement"
            
            //                self.firstItemIcon.isHidden = true
            self.firstItemLabel.text = "New Alexa App"
            
            //                self.secondItemIcon.isHidden = true
            self.secondItemLabel.text = "Equity Recommendation (MSFT)"
            
            //                self.thirdItemIcon.isHidden = true
            self.thirdItemLabel.text = ""
        default:
            self.title.text = ""
        }
    }
}


