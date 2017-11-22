//
//  PaymentsViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import FontAwesomeKit
import NVActivityIndicatorView

class PaymentsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPaymentsMethod()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func loadPaymentsMethod() {
        self.activityIndicatorView.color = UIColor(red:0.00, green:0.29, blue:0.51, alpha:1.0)
        self.activityIndicatorView.startAnimating()
        
        if (PaymentManager.paymentsMethod.count <= 0) {
            
            PaymentManager.paymentsMethod.append(CreditCard(name: "Visa",
                                                  type: PaymentMethodType.CREDIT_CARD,
                                                  image: UIImage(named: "visa")!,
                                                  isDefault: true,
                                                  number: "4342 5622 8903 0560",
                                                  validTill: "10/22",
                                                  cvv: 641,
                                                  zipcode: "90245"))
            
            
            PaymentManager.paymentsMethod.append(CreditCard(name: "Mastercard",
                                                  type: PaymentMethodType.CREDIT_CARD,
                                                  image: UIImage(named: "mastercard")!,
                                                  isDefault: false,
                                                  number: "1620 4467 9832 1134",
                                                  validTill: "07/21",
                                                  cvv: 435,
                                                  zipcode: "02989030"))
        }
        
        self.tableView.tableFooterView = UIView()
        self.tableView.dataSource = self;
        self.tableView.reloadData()
        self.activityIndicatorView.stopAnimating()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddPaymentViewController {
            self.tableView.reloadData()
        }
    }
    
}

extension PaymentsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PaymentManager.paymentsMethod.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell( withIdentifier:"cell", for: indexPath) as! PaymentsTableViewCell
        let paymentMethod = PaymentManager.paymentsMethod[indexPath.row] as! CreditCard
        
        cell.icon.image = paymentMethod.image
        cell.lbName.text = paymentMethod.name
        
        let index = paymentMethod.number.index(paymentMethod.number.endIndex, offsetBy: -4)
        cell.lbNumber.text = paymentMethod.number.substring(from: index)
        cell.lbDefault.text = paymentMethod.isDefault ? "DEFAULT" : ""
        
        cell.lbName.font = UIFont.boldSystemFont(ofSize: 10.0)
        cell.lbNumber.font = UIFont.boldSystemFont(ofSize: 10.0)
        cell.lbDefault.font = UIFont.boldSystemFont(ofSize: 10.0)
        
        return cell
    }
}

