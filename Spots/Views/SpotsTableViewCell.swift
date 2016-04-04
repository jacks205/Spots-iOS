//
//  SpotsTableViewCell.swift
//  Spots
//
//  Created by Mark Jackson on 4/3/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//

import UIKit

class SpotsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: SpotsIndexedCollectionView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var totalSpots: UILabel!
    
    func setCollectionViewDataSourceDelegate(dataSource : UICollectionViewDataSource, withDelegate delegate : UICollectionViewDelegate, atIndexPath indexPath : NSIndexPath) {
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        collectionView.indexPath = indexPath
        collectionView.reloadData()
    }

}
