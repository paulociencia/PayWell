//
//  AddPaymentViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit

class AddPaymentViewController: UIViewController  {
    
    @IBOutlet weak var lbCardNumber: UILabel!
    @IBOutlet weak var txtFieldCardNumber: UITextField!
    @IBOutlet weak var lbValidTill: UILabel!
    @IBOutlet weak var txtFieldValidTill: UITextField!
    @IBOutlet weak var lbCVV: UILabel!
    @IBOutlet weak var txtFieldCVV: UITextField!
    @IBOutlet weak var txtFieldZipCode: UITextField!
    @IBOutlet weak var lbZipCode: UILabel!
    
    var delegate: PaymentMethodAddedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lbCardNumber.font = UIFont.boldSystemFont(ofSize: 10.0)
        self.lbCardNumber.font = UIFont.boldSystemFont(ofSize: 10.0)
        self.lbValidTill.font = UIFont.boldSystemFont(ofSize: 10.0)
        self.lbCVV.font = UIFont.boldSystemFont(ofSize: 10.0)
        self.lbZipCode.font = UIFont.boldSystemFont(ofSize: 10.0)
        self.txtFieldCardNumber.font = UIFont.boldSystemFont(ofSize: 10.0)
        self.txtFieldValidTill.font = UIFont.boldSystemFont(ofSize: 10.0)
        self.txtFieldCVV.font = UIFont.boldSystemFont(ofSize: 10.0)
        self.txtFieldZipCode.font = UIFont.boldSystemFont(ofSize: 10.0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        
        guard let cardNumber = txtFieldCardNumber.text else {
            return
        }
        guard let validTill = txtFieldValidTill.text else {
            return
        }
        guard let cvv = Int(txtFieldCVV.text!) else {
            return
        }
        guard let zipcode = txtFieldZipCode.text else {
            return
        }
        
        let card = CreditCard(name: "Visa",
                              type: PaymentMethodType.CREDIT_CARD,
                              image: UIImage(named: "visa")!,
                              isDefault: false,
                              number: cardNumber,
                              validTill: validTill,
                              cvv: cvv,
                              zipcode: zipcode)
        
        PaymentManager.paymentsMethod.append(card)
        self.delegate?.added(creditCard: card)
        
       // self.performSegue(withIdentifier: "BackPaymentsSegue", sender: nil)
        
    }
}

protocol PaymentMethodAddedDelegate {
    
    func added(creditCard: CreditCard)
}

