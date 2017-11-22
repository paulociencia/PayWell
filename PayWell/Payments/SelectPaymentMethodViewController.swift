//
//  SelectPaymentMethodViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit

class SelectPaymentMethodViewController: UIViewController, PaymentMethodAddedDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var paymentsMethod:[PaymentMethod] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.paymentsMethod.append(PaymentMethod(name: "Credit Card",
                                                 type: PaymentMethodType.CREDIT_CARD,
                                                 image: UIImage(named: "creditcard")!,
                                                 isDefault: false))
        
        self.paymentsMethod.append(PaymentMethod(name: "PayPal",
                                                 type: PaymentMethodType.PAYPAL,
                                                 image: UIImage(named: "paypal")!,
                                                 isDefault: false))
        
        self.tableView.tableFooterView = UIView()
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.reloadData()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddPaymentViewController {
            destination.delegate = self
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func added(creditCard: CreditCard) {
        print("Notify")
        print(creditCard.number)
    }
}


extension SelectPaymentMethodViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.paymentsMethod.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell( withIdentifier:"paymentMethodCell", for: indexPath) as! PaymentMethodTableViewCell
        let paymentMethod = self.paymentsMethod[indexPath.row]
        
        cell.icon.image = paymentMethod.image
        cell.lbName.text = paymentMethod.name
        cell.lbName.font = UIFont.boldSystemFont(ofSize: 10.0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell( withIdentifier:"paymentMethodCell", for: indexPath) as! PaymentMethodTableViewCell
        
        print(cell.lbName.text)
    }
    
}

