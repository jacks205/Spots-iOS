//
//  SpotsIndexedCollectionView.swift
//  Spots
//
//  Created by Mark Jackson on 4/4/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//

import UIKit

class SpotsIndexedCollectionView: UICollectionView {
    
    var indexPath: NSIndexPath!
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
