//
//  AdvisorFullCarouselView.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import FontAwesomeKit

class AdvisorFullCarouselView: UIView {
    @IBOutlet weak var advisorProfileImage: UIImageView!
    @IBOutlet weak var advisorName: UILabel!
    
    @IBOutlet weak var advisorTwitterIcon: UIButton!
    @IBOutlet weak var advisorLinkedinIcon: UIButton!
    
    @IBOutlet weak var advisorTitle: UILabel!
    
    @IBOutlet weak var adivsorAddressIcon: UIButton!
    @IBOutlet weak var advisorAddress1: UILabel!
    @IBOutlet weak var advisorAddress2: UILabel!
    @IBOutlet weak var advisorAddress3: UILabel!
    
    @IBOutlet weak var advisorDirectPhoneIcon: UIButton!
    @IBOutlet weak var advisorDirectPhone: UILabel!
    
    @IBOutlet weak var advisorOfficePhoneIcon: UIButton!
    @IBOutlet weak var advisorOfficePhone: UILabel!
    
    @IBOutlet weak var advisorEmailIcon: UIButton!
    @IBOutlet weak var advisorEmail: UILabel!
    
    var advisorDirectPhoneNumber:String = ""
    var advisorOfficePhoneNumber:String = ""
    var emailAddress = ""
    var linkedinURL = ""
    var twitterURL = ""
    
    class func instanceFromNib() -> AdvisorFullCarouselView {
        return UINib(nibName: "AdvisorFullCarouselView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AdvisorFullCarouselView
    }
    
    
    @IBAction func directPhoneTapped(_ sender: Any) {
        let url = URL(string: "tel://\(self.advisorDirectPhoneNumber)")
        
        UIApplication.shared.open(url!)
    }
    
    @IBAction func mobilePhoneTapped(_ sender: Any) {
        let url = URL(string: "tel://\(self.advisorOfficePhoneNumber)")
        
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
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        self.layer.borderWidth = 0.5
        
        self.emailAddress = advisor.email
        self.linkedinURL = advisor.social_linkedin
        self.twitterURL = advisor.social_twitter
        
        self.advisorDirectPhoneNumber = advisor.telephone_number_direct.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        self.advisorOfficePhoneNumber = advisor.telephone_number_office.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        self.advisorName.text = advisor.firstName + " " + advisor.lastName
        let twitterIcon:FAKIcon = FAKFontAwesome.twitterIcon(withSize: 20)
        let twitterIconImage:UIImage = twitterIcon.image(with: CGSize(width: 20, height: 20))
        self.advisorTwitterIcon.setImage(twitterIconImage, for: UIControlState.normal)
        
        let linkedinIcon:FAKIcon = FAKFontAwesome.linkedinIcon(withSize: 20)
        let linkedinIconimage:UIImage = linkedinIcon.image(with: CGSize(width: 20, height: 20))
        self.advisorLinkedinIcon.setImage(linkedinIconimage, for: UIControlState.normal)
        
        self.advisorTitle.text = advisor.title
        
        let homeIcon:FAKIcon = FAKFontAwesome.homeIcon(withSize: 15)
        let phoneIconImage:UIImage = homeIcon.image(with: CGSize(width: 15, height: 15))
        self.adivsorAddressIcon.setImage(phoneIconImage, for: UIControlState.normal)
        self.advisorAddress1.text = advisor.address_line1
        self.advisorAddress2.text = advisor.address_line2
        self.advisorAddress3.text = advisor.address_line3
        
        let directPhoneIcon:FAKIcon = FAKFontAwesome.mobilePhoneIcon(withSize: 15)
        let directPhoneIconImage:UIImage = directPhoneIcon.image(with: CGSize(width: 15, height: 15))
        self.advisorDirectPhoneIcon.setImage(directPhoneIconImage, for: UIControlState.normal)
        self.advisorDirectPhone.text = advisor.telephone_number_direct
        
        let officePhoneIcon:FAKIcon = FAKFontAwesome.phoneIcon(withSize: 15)
        let officePhoneIconImage:UIImage = officePhoneIcon.image(with: CGSize(width: 15, height: 15))
        self.advisorOfficePhoneIcon.setImage(officePhoneIconImage, for: UIControlState.normal)
        self.advisorOfficePhone.text = advisor.telephone_number_office
        
        let emailicon:FAKIcon = FAKFontAwesome.envelopeIcon(withSize: 15)
        let emailIconImage:UIImage = emailicon.image(with: CGSize(width: 15, height: 15))
        self.advisorEmailIcon.setImage(emailIconImage, for: UIControlState.normal)
        self.advisorEmail.text = "maicon.borges@genesis.global"
    }
}
