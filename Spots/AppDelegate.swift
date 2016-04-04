//
//  AppDelegate.swift
//  Spots
//
//  Created by Mark Jackson on 3/31/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().barTintColor = SpotsAppearance.Background
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        #if DEBUG
            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "school")
        #endif
        
        if let _ = NSUserDefaults.standardUserDefaults().stringForKey("school") {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let spotsVc = mainStoryboard.instantiateInitialViewController()
            let nvc = UINavigationController(rootViewController: spotsVc!)
            window?.rootViewController = nvc
        } else {
            let selectionStoryboard = UIStoryboard(name: "SchoolSelection", bundle: nil)
            let selectionVC = selectionStoryboard.instantiateInitialViewController()
            window?.rootViewController = selectionVC
        }
        
        window?.makeKeyAndVisible()
        
        return true
    }

}
