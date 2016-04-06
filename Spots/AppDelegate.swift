//
//  AppDelegate.swift
//  Spots
//
//  Created by Mark Jackson on 3/31/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        UINavigationBar.appearance().barTintColor = SpotsAppearance.Background
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        if !SpotsSharedDefaults.boolForKey("neverRate") {
            let totalLaunches = SpotsSharedDefaults.integerForKey("launches")
            SpotsSharedDefaults.setInteger(totalLaunches + 1, forKey: "launches")
        }
        
        #if DEBUG
            SpotsSharedDefaults.setObject(nil, forKey: "school")
            Crashlytics().debugMode = true
        #endif
        
        if SpotsSharedDefaults.stringForKey("school") != nil {
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
        
        
        Fabric.with([Crashlytics.self])
        
        return true
    }

}
