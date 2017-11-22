//
//  AppDelegate.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import NVActivityIndicatorView
import AirshipKit
import AI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var shouldRotate : Int! = 0
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.tintColor = UIColor.navigationText
        navigationBarAppearace.barTintColor = UIColor.navigationBg
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.navigationText]
        navigationBarAppearace.shadowImage = UIImage()
        
        // Override point for customization after application launch.
      //  Fabric.with([Crashlytics.self])
        NVActivityIndicatorView.DEFAULT_TYPE = NVActivityIndicatorType.lineScale
        
       /*
            UAirship.takeOff()
            
            UAirship.push().userPushNotificationsEnabled = true
            UAirship.push().defaultPresentationOptions = [.alert, .badge, .sound]
        */
        
        AI.configure("42816683c5ad4dbd911ed894a7d52c93")
        
        return true
    }
    
    func loginSuccessful() {
        var slidingView :ECSlidingViewController!
        let storyboard : UIStoryboard! = UIStoryboard(name: "Main", bundle: nil)
        slidingView = storyboard.instantiateViewController(withIdentifier: "ECSlidingViewController") as! ECSlidingViewController
        UIApplication.shared.keyWindow?.rootViewController = slidingView as ECSlidingViewController
    }
    
    func logout(){
        print("Logout delegate")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}
