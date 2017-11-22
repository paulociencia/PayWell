//
//  AccountManager.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import Foundation

class AccountManager: NSObject {
    private override init() { }
    
    //MARK: Shared Instance
    static let sharedInstance: AccountManager = {
        let instance = AccountManager()
        
        instance.restAPImanager.accounts(completion: { (accounts) in
            instance.accounts = accounts
        })
        
        return instance
    }()
    
    //MARK: Local Variable
    var accounts: [Account] = []
    var restAPImanager: RestAPIManager = RestAPIManager()
    
    func requestAccounts(completion: @escaping ([Account]) -> Void) -> Void {
        if (self.accounts.count > 0) {
            completion(self.accounts)
        } else {
            self.restAPImanager.accounts(completion: { (accounts) in
                self.accounts = accounts
                
                self.restAPImanager.holdings { (holdings) in
                    for holding in holdings {
                        self.addHoldingToAccount(holding: holding)
                    }
                    
                    completion(accounts)
                }
            })
        }
    }
    
    func addHoldingToAccount(holding: Holding) {
        for account in self.accounts {
            if (account.accountId == holding.accountId) {
                account.holdings.append(holding)
                break
            }
        }
        
    }
}

