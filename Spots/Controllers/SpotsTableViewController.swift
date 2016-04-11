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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupTableView()
        setupRefreshControl()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let neverRate = SpotsSharedDefaults.boolForKey("neverRate")
        let totalLaunches = Variable(SpotsSharedDefaults.integerForKey("launches"))
        setupRateAppController(neverRate, totalLaunches: totalLaunches)
        
        refreshControl?.attributedTitle = self.getLastUpdatedAttributedString("Updated " + timeAgoSinceDate(lastUpdated, numericDates: true))
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
        
        refreshControl?.beginRefreshing()
        refreshControl?.rx_controlEvent(.ValueChanged)
            .startWith(())
            .flatMapLatest { [unowned self] (_) -> Observable<SpotsResponse> in
                switch self.school {
                case .CU:
                    return getCUParkingData()
                        .trackActivity(self.activityIndicator)
                case .CSUF:
                    return getCSUFParkingData(self.db)
                        .trackActivity(self.activityIndicator)
                }
            }
            .subscribe { [unowned self] (event) in
                self.parseNetworkEvent(event)
            }
            .addDisposableTo(db)
        
        activityIndicator.asObservable()
            .bindTo(refreshControl!.rx_refreshing)
            .addDisposableTo(db)
        
        activityIndicator.asObservable()
            .bindTo(UIApplication.sharedApplication().rx_networkActivityIndicatorVisible)
            .addDisposableTo(db)
        
        tableView.insertSubview(refreshControl!, atIndex: 0)
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
            if res.lastUpdated != nil {
                self.refreshControl?.attributedTitle = self.getLastUpdatedAttributedString("Updated \(res.lastUpdatedDate.timeAgoString())")
            } else {
                self.refreshControl?.attributedTitle = self.getLastUpdatedAttributedString("Updated \(self.lastUpdated.timeAgoString())")
            }
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
