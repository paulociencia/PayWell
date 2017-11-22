//
//  EditNoteViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import LocalAuthentication

class EditNoteViewController: UIViewController, UIAlertViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.authenticateUser()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func authenticateUser() {
        
        let context = LAContext()
        var policy: LAPolicy?
        var error: NSError?
        let reason = "Authentication is needed to access your notes."
        
        if #available(iOS 9.0, *) {
            // policy = .deviceOwnerAuthentication
            policy = .deviceOwnerAuthenticationWithBiometrics
        } else {
            context.localizedFallbackTitle = "Fuu!"
            policy = .deviceOwnerAuthenticationWithBiometrics
        }
        
        guard context.canEvaluatePolicy(policy!, error: &error) else {
            
            showAlertWithTitle(title: "Error", message: "This device does not have a TouchID sensor.")
            return
        }
        
        
        
        context.evaluatePolicy(policy!, localizedReason: reason, reply: { (success, error) in
            DispatchQueue.main.async {
                
                guard success else {
                    guard let error = error else {
                        self.showAlertWithTitle(title: "UnexpectedError", message: "Unexpected Error")
                        return
                    }
                    switch(error) {
                    case LAError.authenticationFailed:
                        self.showAlertWithTitle(title: "AuthenticationFailed", message: "There was a problem verifying your identity.")
                    case LAError.userCancel:
                        self.showAlertWithTitle(title: "userCancel", message: "Authentication was canceled by user.")
                        // Fallback button was pressed and an extra login step should be implemented for iOS 8 users.
                    // By the other hand, iOS 9+ users will use the pasccode verification implemented by the own system.
                    case LAError.userFallback:
                        self.showAlertWithTitle(title: "userFallback", message: "The user tapped the fallback button (Fuu!)")
                    case LAError.systemCancel:
                        self.showAlertWithTitle(title: "systemCancel", message: "Authentication was canceled by system.")
                    case LAError.passcodeNotSet:
                        self.showAlertWithTitle(title: "passcodeNotSet", message: "Passcode is not set on the device.")
                    case LAError.biometryNotAvailable:
                        self.showAlertWithTitle(title: "touchIDNotAvailable", message: "Touch ID is not available on the device.")
                    case LAError.biometryNotEnrolled:
                        self.showAlertWithTitle(title: "touchIDNotEnrolled", message: "Touch ID has no enrolled fingers.")
                    // iOS 9+ functions
                    case LAError.biometryLockout:
                        self.showAlertWithTitle(title: "touchIDLockout", message: "There were too many failed Touch ID attempts and Touch ID is now locked.")
                    case LAError.appCancel:
                        self.showAlertWithTitle(title: "appCancel", message: "Authentication was canceled by application.")
                    case LAError.invalidContext:
                        self.showAlertWithTitle(title: "invalidContext", message: "LAContext passed to this call has been previously invalidated.")
                    default:
                        self.showAlertWithTitle(title: "TouchIDNotConfigured", message: "Touch ID may not be configured.")
                        break
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    self.showAlertWithTitle(title: "SUCESS", message: String(success))
                }
                
                
            }
        })
        
        
    }
    
    
    
    func showPasswordAlert() {
        var passwordAlert : UIAlertView = UIAlertView(title: "TouchIDDemo", message: "Please type your password", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Okay")
        passwordAlert.alertViewStyle = UIAlertViewStyle.secureTextInput
        passwordAlert.show()
    }
    
    
    
    func showAlertWithTitle( title:String, message:String ) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
}

