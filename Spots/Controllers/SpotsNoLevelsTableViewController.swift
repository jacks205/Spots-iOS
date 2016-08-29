//
//  SpotsNoLevelsTableViewController.swift
//  Spots
//
//  Created by Mark Jackson on 4/7/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//

import UIKit
import RxSwift

class SpotsNoLevelsTableViewController: SpotsTableViewController {

    override func setupTableView() {
        super.setupTableView()
        
        structures.asObservable()
            .bindTo(tableView.rx_itemsWithCellIdentifier("NoLevelsCell", cellType: SpotsNoLevelsTableViewCell.self)) { (row, structure, cell) in
                cell.title.text = structure.name.capitalizedString
                cell.totalSpots.text = "\(structure.available) spots available"
                cell.lastUpdated.text = "Updated \(structure.lastUpdatedDate.timeAgoString())"
                cell.percentageCircleDataView.percentageCircleView.setCapacityLevel(CGFloat(structure.available), outOfTotalCapacity: CGFloat(structure.total))
                cell.percentageCircleDataView.percentageCircleView.animateCircle(Double(row + 1) * 0.15)
            }
            .addDisposableTo(db)
    }
    
    override func setupRefreshControl() {
        super.setupRefreshControl()
        
        refreshControl?.rx_controlEvent(.ValueChanged)
            .startWith(())
            .flatMapLatest { [unowned self] (_) -> Observable<SpotsResponse> in
                return getCSUFParkingData()
                    .trackActivity(self.activityIndicator)
            }
            .subscribe { [unowned self] (event) in
                self.parseNetworkEvent(event)
            }
            .addDisposableTo(db)
    }
    
    

}
