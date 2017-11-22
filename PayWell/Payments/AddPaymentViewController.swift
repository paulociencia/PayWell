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
            self.displayAlert(message: "Invalid Card Number!", buttonTitle: "Ok", vc: self)
            return
        }
        guard let validTill = txtFieldValidTill.text else {
            self.displayAlert(message: "Invalid Valid Till!", buttonTitle: "Ok", vc: self)
            return
        }
        guard let cvv = Int(txtFieldCVV.text!) else {
            self.displayAlert(message: "Invalid CVV!", buttonTitle: "Ok", vc: self)
            return
        }
        guard let zipcode = txtFieldZipCode.text else {
            self.displayAlert(message: "Invalid Zip Code!", buttonTitle: "Ok", vc: self)
            return
        }
        
        let creditCardValidator = CreditCardValidator()
        let result = creditCardValidator.checkCardNumber(input: cardNumber)
        
        if (!result.valid) {
            self.displayAlert(message: "Invalid Valid Till!", buttonTitle: "Ok", vc: self)
            return
        }
        
        let card = CreditCard(name: result.type.rawValue,
                              type: PaymentMethodType.CREDIT_CARD,
                              image: UIImage(named: "visa")!,
                              isDefault: false,
                              number: result.formatted,
                              validTill: validTill,
                              cvv: cvv,
                              zipcode: zipcode)
        
        PaymentManager.paymentsMethod.append(card)
        self.delegate?.added(creditCard: card)
        
       // self.performSegue(withIdentifier: "BackPaymentsSegue", sender: nil)
        
    }
    
    func displayAlert(message: String, buttonTitle: String, vc: UIViewController)
    {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alertController.addAction(OKAction)
        
        vc.present(alertController, animated: true, completion: nil)
    }

}

protocol PaymentMethodAddedDelegate {
    
    func added(creditCard: CreditCard)
}

