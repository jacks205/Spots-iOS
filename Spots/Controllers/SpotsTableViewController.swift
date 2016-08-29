//
//  SpotsViewController.swift
//  Spots
//
//  Created by Mark Jackson on 3/31/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import Moya_ObjectMapper
import RxDataSources
import GoogleMobileAds

let minimumSessions = 4
let maybeLaterSessions = minimumSessions + 8

class SpotsTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var structures : Variable<[Structure]> = Variable([])
    var refreshControl : UIRefreshControl?
    var school = School.CU
    
    let activityIndicator = ActivityIndicator()
    let db = DisposeBag()
    
    var lastUpdated = NSDate()
    
    let bannerView: GADBannerView = {
        let v = GADBannerView(adSize: kGADAdSizeBanner)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.adUnitID = ADMOB_UNIT_ID
        return v
    }()
    
    let bannerViewHeight: CGFloat = 50.0
    
    private var bannerAdRequest: GADRequest {
        get {
            let req = GADRequest()
            #if DEBUG
                req.testDevices = [kGADSimulatorID]
            #endif
            return req
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupTableView()
        setupRefreshControl()
        setupBannerView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        bannerView.loadRequest(bannerAdRequest)
        
        let neverRate = SpotsSharedDefaults.boolForKey("neverRate")
        let totalLaunches = Variable(SpotsSharedDefaults.integerForKey("launches"))
        setupRateAppController(neverRate, totalLaunches: totalLaunches)
        
        refreshControl?.attributedTitle = self.getLastUpdatedAttributedString("Updated \(lastUpdated.timeAgoString())")
    }
    
    internal func setupAppearance() {
        if let smallerFont = UIFont(name: "OpenSans", size: 11) {
            title = "PARKING STRUCTURES"
            navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: smallerFont, NSForegroundColorAttributeName: UIColor(red: 1, green: 1, blue: 1, alpha: 0.48)]
        }
        
        view.backgroundColor = SpotsAppearance.Background
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.translucent = false
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    internal func setupTableView() {
        tableView
            .rx_setDelegate(self)
            .addDisposableTo(db)
    }
    
    internal func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = getLastUpdatedAttributedString("Loading...")
        refreshControl?.beginRefreshing()
        
        activityIndicator.asObservable()
            .bindTo(refreshControl!.rx_refreshing)
            .addDisposableTo(db)
        
        activityIndicator.asObservable()
            .bindTo(UIApplication.sharedApplication().rx_networkActivityIndicatorVisible)
            .addDisposableTo(db)
        
        tableView.insertSubview(refreshControl!, atIndex: 0)
    }
    
    internal func setupBannerView() {
        view.addSubview(bannerView)
        bannerView.rootViewController = self
        bannerView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        bannerView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        bannerView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        bannerView.heightAnchor.constraintEqualToConstant(bannerViewHeight).active = true
    }
    
    override func viewDidLayoutSubviews() {
        tableView.contentInset.bottom = bannerViewHeight
    }
    
    internal func setupRateAppController(neverRate : Bool, totalLaunches : Variable<Int>) {
        totalLaunches.asObservable()
            .filter { !neverRate && ($0 == minimumSessions + 1 || $0 > minimumSessions + maybeLaterSessions) }
            .subscribeNext { launches in
                self.presentRateController()
                SpotsSharedDefaults.setInteger(minimumSessions + 1, forKey: "launches")
            }
            .addDisposableTo(db)
    }
    
    internal func presentRateController() {
        let alert = UIAlertController(title: "Rate Us", message: "Thanks for using Spots. Please go rate us in the App Store!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Rate Spots", style: UIAlertActionStyle.Default, handler: { alertAction in
            let appStoreUrl = NSURL(string: APP_STORE_URL)!
            if UIApplication.sharedApplication().canOpenURL(appStoreUrl) {
                UIApplication.sharedApplication().openURL(appStoreUrl)
                SpotsSharedDefaults.setBool(true, forKey: "neverRate")
            }
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No Thanks", style: UIAlertActionStyle.Default, handler: { alertAction in
            SpotsSharedDefaults.setBool(true, forKey: "neverRate")
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Maybe Later", style: UIAlertActionStyle.Default, handler: { alertAction in
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    //MARK: - Spots Requests
    
    internal func parseNetworkEvent(event : Event<SpotsResponse>) {
        switch event {
        case .Next(let res):
            self.lastUpdated = NSDate()
            self.structures.value = res.structures
            self.refreshControl?.attributedTitle = self.getLastUpdatedAttributedString("Updated \(res.lastUpdatedDate.timeAgoString())")
            break
        case .Error(let err):
            print(err)
            break
        case .Completed:
            break
        }
    }
    
    //MARK: - Helper Methods
    internal func getLastUpdatedAttributedString(string : String) -> NSAttributedString {
        return NSAttributedString(string: string, attributes:
            [
                NSFontAttributeName: UIFont(name: "OpenSans", size: 11)!,
                NSForegroundColorAttributeName: UIColor(red: 1, green: 1, blue: 1, alpha: 0.48)
            ]
        )
    }
    
}

extension SpotsTableViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .None
    }
    
}
