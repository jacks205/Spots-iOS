//
//  SpotsLevelsTableViewController.swift
//  Spots
//
//  Created by Mark Jackson on 4/7/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//

import UIKit

class SpotsLevelsTableViewController: SpotsTableViewController {
    
    override func setupTableView() {
        super.setupTableView()
        
        structures.asObservable()
            .bindTo(tableView.rx_itemsWithCellIdentifier("LevelsCell", cellType: SpotsLevelsTableViewCell.self)) { (row, structure, cell) in
                cell.selectionStyle = .None
                cell.title.text = structure.name.capitalizedString
                cell.totalSpots.text = "\(structure.available) spots available"
            }
            .addDisposableTo(db)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let spotsCell = cell as? SpotsLevelsTableViewCell {
            let structure = structures.value[indexPath.row]
            spotsCell.setCollectionViewStructure(structure, atIndexPath: indexPath)
        }
    }

}
