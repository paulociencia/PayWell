//
//  AdvisorCarouselView.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import FontAwesomeKit


class AdvisorCarouselView: UIView {
    @IBOutlet weak var advisorName: UILabel!
    @IBOutlet weak var advisorTitle: UILabel!
    
    @IBOutlet weak var mobilePhone: UIButton!
    @IBOutlet weak var directPhone: UIButton!
    
    @IBOutlet weak var twitter: UIButton!
    @IBOutlet weak var email: UIButton!
    @IBOutlet weak var linkedin: UIButton!
    
    var advisorDirectPhoneNumber:String = ""
    var advisorMobilePhoneNumber:String = ""
    var emailAddress = ""
    var linkedinURL = ""
    var twitterURL = ""
    
    class func instanceFromNib() -> AdvisorCarouselView {
        return UINib(nibName: "AdvisorCarouselViewNew", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AdvisorCarouselView
    }
    
    @IBAction func directPhoneTapped(_ sender: Any) {
        let url = URL(string: "tel://\(self.advisorDirectPhoneNumber)")
        
        UIApplication.shared.open(url!)
    }
    
    @IBAction func mobilePhoneTapped(_ sender: Any) {
        let url = URL(string: "tel://\(self.advisorMobilePhoneNumber)")
        
        UIApplication.shared.open(url!)
    }
    
    @IBAction func emailTapped(_ sender: Any) {
        let url = URL(string: "mailto:\(self.emailAddress)")
        
        UIApplication.shared.open(url!)
    }
    
    @IBAction func linkedinTapped(_ sender: Any) {
        let url = URL(string: self.linkedinURL)
        
        UIApplication.shared.open(url!)
    }
    
    @IBAction func twitterTapped(_ sender: Any) {
        let url = URL(string: self.twitterURL)
        
        UIApplication.shared.open(url!)
    }
    
    func populateFromAdvisor(advisor:Advisor) {
        let borderColor = UIColor.lightGray.withAlphaComponent(0.6)
        
        self.emailAddress = advisor.email
        self.linkedinURL = advisor.social_linkedin
        self.twitterURL = advisor.social_twitter
        
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 0.5
        
        let iconSize:CGFloat = 15.0
        let phoneicon:FAKIcon = FAKFontAwesome.mobilePhoneIcon(withSize: iconSize)
        let directicon:FAKIcon = FAKFontAwesome.phoneIcon(withSize: iconSize)
        let tweeticon:FAKIcon = FAKFontAwesome.twitterIcon(withSize: iconSize)
        let linkedinicon:FAKIcon = FAKFontAwesome.linkedinIcon(withSize: iconSize)
        let emailicon:FAKIcon = FAKFontAwesome.envelopeIcon(withSize: iconSize)
        
        let iconColor = UIColor.init(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        
        phoneicon.addAttribute(NSForegroundColorAttributeName, value: iconColor)
        
        self.mobilePhone.setImage(phoneicon.image(with: CGSize(width: iconSize, height: iconSize)), for: UIControlState.normal)
        self.directPhone.setImage(directicon.image(with: CGSize(width: iconSize, height: iconSize)), for: UIControlState.normal)
        self.twitter.setImage(tweeticon.image(with: CGSize(width: iconSize, height: iconSize)), for: UIControlState.normal)
        self.linkedin.setImage(linkedinicon.image(with: CGSize(width: iconSize, height: iconSize)), for: UIControlState.normal)
        self.email.setImage(emailicon.image(with: CGSize(width: iconSize, height: iconSize)), for: UIControlState.normal)
        
        self.advisorName.text = advisor.firstName + " " + advisor.lastName
        self.advisorTitle.text = advisor.title
        
        self.advisorDirectPhoneNumber = advisor.telephone_number_direct.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        self.advisorMobilePhoneNumber = advisor.telephone_number_mobile.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}
