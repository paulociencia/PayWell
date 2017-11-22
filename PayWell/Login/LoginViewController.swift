//
//  LoginViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoginViewController: UIViewController {


    @IBOutlet var contentScroll: UIScrollView!
    @IBOutlet var txtUsername : UITextField!
    @IBOutlet var txtPassword : UITextField!
    @IBOutlet weak var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.loginBg
        self.signInButton.backgroundColor = UIColor.loginButtonBg
        self.signInButton.titleLabel?.textColor = UIColor.loginButtonText
        self.txtUsername.textColor = UIColor.loginButtonText
        self.txtPassword.textColor = UIColor.loginButtonText
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.willShowKeyBoard(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.willHideKeyBoard(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        txtUsername.setValue(UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1), forKeyPath: "_placeholderLabel.textColor")
        txtPassword.setValue(UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1), forKeyPath: "_placeholderLabel.textColor")
    }

    @objc func willShowKeyBoard(_ notification : Notification){
        
        contentScroll.setContentOffset(CGPoint(x: 0, y: 120), animated: true);
    }

    @objc func willHideKeyBoard(_ notification : Notification){
        
        contentScroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true);
    }

    func textFieldShouldReturn (_ textField: UITextField!) -> Bool{
        if ((textField == txtUsername)){
            txtPassword.becomeFirstResponder();
        } else if (textField == txtPassword){
            textField.resignFirstResponder()
        }
        return true
    }

    @IBAction func loginSuccessful() {
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        print("Login was called")
        let restAPIManager = RestAPIManager();
        
        restAPIManager.Login(username: txtUsername.text!, password: txtPassword.text!) { (isLoggedIn) in
            if(isLoggedIn == true) {
                let appDelegate : AppDelegate! = UIApplication.shared.delegate as! AppDelegate
                appDelegate.loginSuccessful()
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            } else {
                print("Invalid user or password");
            }
        }
    }

    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}

