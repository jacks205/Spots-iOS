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
import Moya_ObjectMapper

class SpotsTableViewController: UITableViewController {
    
    var structures : [Structure] = []
    
    let db = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(reloadParkingData), forControlEvents: .ValueChanged)
        reloadParkingData(self)
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
    
    func reloadParkingData(sender : AnyObject) {
        getParkingData()
    }
    
    //MARK: - Spots Requests
    
    private func getParkingData() {
        let spotsData = SpotsAPI.getSpotsData()
        spotsData
            .subscribe({ [weak self] (event) in
                switch event {
                case .Next(let spotsResponse):
                    self?.structures = spotsResponse.structures
                    self?.tableView.reloadData()
                    break
                case .Error(let err):
                    print(err)
                    break
                case .Completed:
                    break
                }
                self?.refreshControl?.endRefreshing()
                })
            .addDisposableTo(db)
    }
    
}
