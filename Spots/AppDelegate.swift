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
        setupAppearances()
        
        if !SpotsSharedDefaults.boolForKey("neverRate") {
            incrementLaunchCount()
        }
        
        setupFabric()
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = getStartingViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}

private func getStartingViewController() -> UIViewController {
    #if DEBUG
        SpotsSharedDefaults.setObject(nil, forKey: "school")
    #endif
    
    guard SpotsSharedDefaults.stringForKey("school") != nil else {
        let selectionStoryboard = UIStoryboard(name: "SchoolSelection", bundle: nil)
        let selectionVC = selectionStoryboard.instantiateInitialViewController()
        return selectionVC!
    }
    
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let spotsVc = mainStoryboard.instantiateInitialViewController()
    let nvc = UINavigationController(rootViewController: spotsVc!)
    return nvc
}

private func incrementLaunchCount() {
    let totalLaunches = SpotsSharedDefaults.integerForKey("launches")
    SpotsSharedDefaults.setInteger(totalLaunches + 1, forKey: "launches")
}

private func setupAppearances() {
    UINavigationBar.appearance().barTintColor = SpotsAppearance.Background
}

private func setupFabric() {
    #if DEBUG
        Crashlytics().debugMode = true
    #endif
    Fabric.with([Crashlytics.self])
}
