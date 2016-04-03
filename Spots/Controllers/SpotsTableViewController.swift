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

class SpotsTableViewController: UITableViewController {
    
    var structures : [Structure] = []
    var provider : SpotsAPIProvider = SpotsProvider
    
    let activityIndicator = ActivityIndicator()
    let db = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        
        refreshControl!.rx_controlEvent(.ValueChanged)
        .startWith(())
        .flatMapLatest { [unowned self] (_) in
            return self.getParkingDataFromProvider()
            .trackActivity(self.activityIndicator)
        }
        .subscribe { [unowned self] (event) in
            self.parseNetworkEvent(event)
        }
        .addDisposableTo(db)
        
        activityIndicator.asObservable()
        .bindTo(refreshControl!.rx_refreshing)
        .addDisposableTo(db)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let structure = structures[indexPath.row]
        
        cell.textLabel?.text = structure.name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return structures.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    //MARK: - Spots Requests
    
    private func getParkingDataFromProvider() -> Observable<SpotsResponse> {
        return SpotsAPI.getSpotsData(provider)
    }
    
    private func parseNetworkEvent(event : Event<SpotsResponse>) {
        switch event {
        case .Next(let res):
            self.structures = res.structures
            self.tableView.reloadData()
            break
        case .Error(let err):
            print(err)
            break
        case .Completed:
            break
        }
    }
    
}
