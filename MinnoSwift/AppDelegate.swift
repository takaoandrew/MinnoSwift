//
//  AppDelegate.swift
//  MinnoSwift
//
//  Created by Andrew Takao on 6/25/17.
//  Copyright © 2017 Andrew Takao. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        let bounds: CGRect = UIScreen.main.bounds
        let screenHeight: CGFloat = bounds.size.height
        var deviceFamily: String
        
        var mainView: UIStoryboard!
        mainView = UIStoryboard(name: "Main", bundle: nil)
        let viewController : UIViewController = mainView.instantiateViewController(withIdentifier: "ProfileViewController") as UIViewController
        self.window!.rootViewController = viewController
        
        if screenHeight >= 580  {
            print("big iPhone")
            deviceFamily = "iPhoneOriginal"
            // Load Storyboard with name: iPhone4
            var mainView: UIStoryboard!
            mainView = UIStoryboard(name: "Main", bundle: nil)
            let viewcontroller : UIViewController = mainView.instantiateViewController(withIdentifier: "ProfileViewController") as UIViewController
            self.window!.rootViewController = viewcontroller
            
        } else {
            print("small iPhone")
            var mainView: UIStoryboard!
            mainView = UIStoryboard(name: "5s", bundle: nil)
            let viewcontroller : UIViewController = mainView.instantiateViewController(withIdentifier: "LoginViewController") as UIViewController
            self.window!.rootViewController = viewcontroller
            
            if screenHeight == 920 {
                
                deviceFamily = "Pad"
                // Load Storyboard with name: ipad
                var mainView: UIStoryboard!
                mainView = UIStoryboard(name: "IpadStoryboard", bundle: nil)
                let viewcontroller : UIViewController = mainView.instantiateViewController(withIdentifier: "ipad") as UIViewController
                self.window!.rootViewController = viewcontroller
            }
        }
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

