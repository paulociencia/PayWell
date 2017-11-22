//
//  RestAPIManager.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RestAPIManager : UIViewController {
    
    // MARK: Properties
    public let sessionValues = UserDefaults.standard;
    public let URL_FRAMEWORK_LOGIN = "http://52.214.44.252:9064/txn-login-auth";
    public let URL_FRAMEWORK_ACCOUNTS = "http://52.214.44.252:9064/req-account";
    public let URL_FRAMEWORK_ACCOUNT_SUMMARY = "http://52.214.44.252:9064/req-client-summaries";
    public let URL_FRAMEWORK_HOLDING = "http://52.214.44.252:9064/req-holding";
    public let URL_FRAMEWORK_APPOINTMENTS = "http://52.214.44.252:8082/api/v1/appointments/client/StephenMurphy";
    public let URL_FRAMEWORK_ADVISOR = "http://52.214.44.252:9064/req-ADVISORS-BY-CLIENT"
    public let URL_FRAMEWORK_NEWS = "http://52.214.44.252:9064/req-NEWS"
    public let URL_FRAMEWORK_ANNOUNCEMENTS = "http://52.214.44.252:9064/ALL_ANNOUNCEMENTS"
    public let URL_FRAMEWORK_ALL_HOLDINGS = "http://52.214.44.252:9064/ALL_HOLDINGS"
    public let URL_FRAMEWORK_NOTIFICATIONS = "http://52.214.44.252:9064/req-NOTIFICATIONS_BY_CLIENT"
    public let URL_FRAMEWORK_ALERTS = "http://52.214.44.252:9064/ALL_TAURUS_ALERTS"
    
    
    func randomNum() -> String {
        let randomNum:UInt32 = arc4random_uniform(100000000)
        return String(randomNum)
    }
    
    // MARK: API call methods
    func makeGetCall(url:String, params:[String:Any], completion: @escaping (JSON) -> Void) {
        let authToken = sessionValues.string(forKey: "SESSION_AUTH_TOKEN")
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json",
            "SOURCE_REF": "878347834743347",
            "SESSION_AUTH_TOKEN" : authToken!
        ]
        var result:JSON = "";
        
        Alamofire.request(url, parameters: params, headers: headers).validate(statusCode: 200..<600).responseJSON() {
            response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    result = JSON(value)
                    completion(result)
                }
                
            case .failure(let error):
                print("RESPONSE ERROR: \(error)")
            }
        }
    }
    
    
    func makePostCall(url:String, params:[String:Any], header:HTTPHeaders, completion: @escaping (JSON) -> Void) {
        
        let authToken = sessionValues.string(forKey: "SESSION_AUTH_TOKEN")
        let userId = sessionValues.string(forKey: "USER_ID")
        let random = randomNum()
        
        //let headers = header
        /*let headers = [
         "Content-Type":"application/json",
         "SOURCE_REF": random,
         "SESSION_AUTH_TOKEN" : authToken!
         ]*/
        
        var result:JSON = "";
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<600).responseJSON() { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    result = JSON(value)
                    completion(result)
                }
                
            case .failure(let error):
                print("RESPONSE ERROR: \(error)")
            }
            
        }
    }
    
    // MARK: Helper Methods
    
    func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: Locale.current.identifier)
        let result = formatter.string(from: value as NSNumber)
        return result!
    }
    
    // MARK: Login Method
    
    public func Login(username:String, password:String, completion: @escaping (Bool) -> Void) -> Void {
        
        let headers = [
            "Content-Type":"application/json",
            "SOURCE_REF":"1"
        ]
        
        let params: Parameters = [
            "MESSAGE_TYPE": "TXN_LOGIN_AUTH",
            "SERVICE_NAME": "AUTH_MANAGER",
            "DETAILS" : [
                "PASSWORD" : password,
                "USER_NAME" : username
            ]
        ]
        
        
        Alamofire.request(URL_FRAMEWORK_LOGIN, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200..<600).responseJSON() { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    
                    let json = JSON(value)
                    
                    let sessionAuthToken = json["SESSION_AUTH_TOKEN"].string
                    let sessionUserId = json["USER_ID"].string
                    
                    if(sessionAuthToken == nil) {
                        completion(false)
                    } else {
                        self.sessionValues.set(sessionAuthToken, forKey: "SESSION_AUTH_TOKEN")
                        self.sessionValues.set(sessionUserId, forKey: "USER_ID")
                        print(json);
                        completion(true)
                    }
                }
                
            case .failure(let error):
                print("RESPONSE ERROR: \(error)")
                completion(false)
                
            }
        }
    }
    
    func todayWinners(completion: @escaping ([Holding]) -> Void) -> Void{
        
        let authToken = sessionValues.string(forKey: "SESSION_AUTH_TOKEN")
        let userId = sessionValues.string(forKey: "USER_ID")
        let random = randomNum()
        
        let headers:HTTPHeaders = [
            "Content-Type":"application/json",
            "SOURCE_REF": random,
            "SESSION_AUTH_TOKEN" : authToken!,
            "USER_NAME" : userId!
        ]
        
        let params: Parameters = [
            "DETAILS" : [
                "DATASOURCE_NAME" : "ALL_HOLDINGS",
                "ORDER_BY" : "ALL_HOLDINGS_BY_PCT_CHANGE",
                "MAX_ROWS": 5,
                "REVERSE" : true
            ]
        ]
        
        print("WINNERS WAS CALLED");
        
        
        makePostCall(url: URL_FRAMEWORK_ALL_HOLDINGS, params: params, header: headers) { (completed) in
            
            let json = JSON(completed)
            
            let rows = completed["ROW"]
            var holdingsArray:[Holding] = []
            
            rows.forEach({ (holding) in
                let holdingNew = Holding(json: holding.1)
                holdingsArray.append(holdingNew)
            })
            
            print(holdingsArray)
            completion(holdingsArray)
        }
    }
    
    func todayLosers(completion: @escaping ([Holding]) -> Void) -> Void{
        
        let authToken = sessionValues.string(forKey: "SESSION_AUTH_TOKEN")
        let userId = sessionValues.string(forKey: "USER_ID")
        let random = randomNum()
        
        let headers = [
            "Content-Type":"application/json",
            "SOURCE_REF": random,
            "SESSION_AUTH_TOKEN" : authToken!,
            "USER_NAME" : userId!
        ]
        
        let params: Parameters = [
            "DETAILS" : [
                "DATASOURCE_NAME" : "ALL_HOLDINGS",
                "ORDER_BY" : "ALL_HOLDINGS_BY_PCT_CHANGE",
                "MAX_ROWS": 5
            ]
        ]
        
        makePostCall(url: URL_FRAMEWORK_ALL_HOLDINGS, params: params, header: headers) { (completed) in
            
            let json = JSON(completed)
            
            let rows = completed["ROW"]
            var holdingsArray:[Holding] = []
            
            rows.forEach({ (holding) in
                let holdingNew = Holding(json: holding.1)
                holdingsArray.append(holdingNew)
            })
            
            print(holdingsArray)
            completion(holdingsArray)
        }
    }
    
    // MARK: Get Data Methods
    
    func appointments(completion: @escaping (Array<Appointment>) -> Void){
        
        // use get call
        
        let parameters = [
            "" : ""
        ]
        makeGetCall(url: URL_FRAMEWORK_APPOINTMENTS, params: parameters) { (completed) in
            
            let appointments = completed;
            var appointmentsArray:[Appointment] = []
            print(appointments);
            appointments.forEach({ (appointment) in
                let appointmentNew = Appointment(json: appointment.1)
                appointmentsArray.append(appointmentNew)
            })
            
            completion(appointmentsArray)
        }
    }
    
    func notifications(completion: @escaping ([Notification]) -> Void) -> Void{
        let userId = sessionValues.string(forKey: "USER_ID")
        
        let parameters = [
            "REQUEST.NOTIFICATION_ID" : "*",
            "REQUEST.CLIENT_ID" : userId!
        ]
        
        makeGetCall(url: URL_FRAMEWORK_NOTIFICATIONS, params: parameters) { (completed) in
            
            let notifications = completed["REPLY"];
            
            var notificationsArray:[Notification] = []
            print(notifications);
            notifications.forEach({ (holding) in
                let notificationgNew = Notification(json: holding.1)
                notificationsArray.append(notificationgNew)
            })
            
            completion(notificationsArray)
        }
        
    }
    
    func announcements(completion: @escaping (Array<Announcements>) -> Void){
        
        let authToken = sessionValues.string(forKey: "SESSION_AUTH_TOKEN")
        let userId = sessionValues.string(forKey: "USER_ID")
        let random = randomNum()
        
        let headers = [
            "Content-Type":"application/json",
            "SOURCE_REF": random,
            "SESSION_AUTH_TOKEN" : authToken!
        ]
        
        let params: Parameters = [
            "DETAILS" : [
                "DATASOURCE_NAME" : "ALL_ANNOUNCEMENTS",
                "CRITERIA_MATCH": "USER_ID==\"\(userId!)\"",
                "ORDER_BY" : "ALL_ANNOUNCEMENTS_BY_DATE_TIME",
                "MAX_ROWS": 10,
                "REVERSE" : true
            ]
        ]
        
        
        makePostCall(url: URL_FRAMEWORK_ANNOUNCEMENTS, params: params, header: headers) { (completed) in
            
            let json = JSON(completed)
            
            let rows = completed["ROW"]
            var announcementArray:[Announcements] = []
            
            rows.forEach({ (announcement) in
                let announcementNew = Announcements(json: announcement.1)
                announcementArray.append(announcementNew)
            })
            
            print(announcementArray)
            completion(announcementArray)
        }
    }
    
    
    
    func news(completion: @escaping (Array<News>) -> Void){
        let userId = sessionValues.string(forKey: "USER_ID")
        
        let parameters = [
            "REQUEST.USER_ACKNOWLEDGED" : "true",
            "REQUEST.NEWS_ID" : "*",
            "REQUEST.USER_ID": userId!
        ]
        
        makeGetCall(url: URL_FRAMEWORK_NEWS, params: parameters) { (completed) in
            
            let news = completed["REPLY"];
            
            var newsArray:[News] = []
            news.forEach({ (new) in
                let newsNew = News(json: new.1)
                newsArray.append(newsNew)
            })
            
            completion(newsArray)
        }
    }
    
    func advisors(completion: @escaping (Array<Advisor>) -> Void) {
        let userId = sessionValues.string(forKey: "USER_ID")
        
        let parameters = [
            "REQUEST.CLIENT_ID" : userId!
        ]
        
        makeGetCall(url: URL_FRAMEWORK_ADVISOR, params: parameters) { (completed) in
            
            let advisors = completed["REPLY"];
            
            var advisorsArray:[Advisor] = []
            advisors.forEach({ (advisor) in
                let advisorNew = Advisor(json: advisor.1)
                advisorsArray.append(advisorNew)
            })
            
            completion(advisorsArray)
        }
    }
    
    
    
    func accountSummary(completion: @escaping (Any) -> Void) -> Void {
        let userId = sessionValues.string(forKey: "USER_ID")
        let parameters = [
            "REQUEST.CLIENT_ID" : userId!
        ]
        
        makeGetCall(url: URL_FRAMEWORK_ACCOUNT_SUMMARY, params: parameters) { (completed) in
            var value = completed["REPLY"][0]["VALUE"];
            
            if(value != JSON.null) {
                let a = value.double
                let b = self.formatCurrency(value: a!)
                
                completion(b)
            } else {
                value = 0
                completion("$\(value)")
            }
        }
    }
    
    func holdings(completion: @escaping ([Holding]) -> Void) -> Void {
        let userId = sessionValues.string(forKey: "USER_ID")
        
        let parameters = [
            "REQUEST.HOLDING_ID" : "*",
            "REQUEST.CLIENT_ID" : userId!
        ]
        
        makeGetCall(url: URL_FRAMEWORK_HOLDING, params: parameters) { (completed) in
            let holdings = completed["REPLY"];
            
            var holdingsArray:[Holding] = []
            
            holdings.forEach({ (holding) in
                let holdingNew = Holding(json: holding.1)
                holdingsArray.append(holdingNew)
            })
            
            completion(holdingsArray)
        }
    }
    
    func accounts(completion: @escaping ([Account]) -> Void) -> Void {
        let userId = sessionValues.string(forKey: "USER_ID")
        
        let parameters = [
            "REQUEST.ACCOUNT_ID" : "*",
            "REQUEST.USER_ID" : userId!
        ]
        
        makeGetCall(url: URL_FRAMEWORK_ACCOUNTS, params: parameters) { (completed) in
            let accounts = completed["REPLY"];
            
            var accountsArray:[Account] = []
            
            accounts.forEach({ (account) in
                accountsArray.append(Account(json: account.1))
            })
            
            completion(accountsArray)
        }
    }
    
    func alerts(completion: @escaping (Array<Alerts>) -> Void){
        
        let authToken = sessionValues.string(forKey: "SESSION_AUTH_TOKEN")
        let userId = sessionValues.string(forKey: "USER_ID")
        let random = randomNum()
        
        let headers = [
            "Content-Type":"application/json",
            "SOURCE_REF": random,
            "SESSION_AUTH_TOKEN" : authToken!
        ]
        
        let params: Parameters = [
            "DETAILS" : [
                "DATASOURCE_NAME" : "ALL_TAURUS_ALERTS",
                "CRITERIA_MATCH": "USER_ID==\"\(userId!)\"",
                "ORDER_BY" : "ALL_TAURUS_ALERTS_BY_DATE_TIME",
                "MAX_ROWS": 10,
                "REVERSE" : true
            ]
        ]
        
        makePostCall(url: URL_FRAMEWORK_ALERTS, params: params, header: headers) { (completed) in
            
            let json = JSON(completed)
            
            let rows = completed["ROW"]
            var alertsArray:[Alerts] = []
            
            rows.forEach({ (alert) in
                let alertsNew = Alerts(json: alert.1)
                alertsArray.append(alertsNew)
            })
            
            completion(alertsArray)
        }
    }
    
}

