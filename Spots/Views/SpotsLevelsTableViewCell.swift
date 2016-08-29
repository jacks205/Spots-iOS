//
//  SpotsTableViewCell.swift
//  Spots
//
//  Created by Mark Jackson on 4/3/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SpotsLevelsTableViewCell: UITableViewCell, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: SpotsIndexedCollectionView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var totalSpots: UILabel!
    
    var indexPath : NSIndexPath!
    
    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<Structure, Level>>()
    let structureObserver : Variable<[SectionModel<Structure, Level>]> = Variable([])
    
    let db = DisposeBag()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        dataSource.configureCell = { (model, collectionView, indexPath, level) in
            let structure = model.sectionAtIndex(0).model
            let levelCell : UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("LevelCell", forIndexPath: indexPath)
            guard let spotsCircleCollectionCell = levelCell as? SpotsCircleCollectionViewCell else {
                return levelCell
            }
            
            let levelRow = indexPath.row
            guard levelRow < structure.levels.count else {
                let emptyCell = collectionView.dequeueReusableCellWithReuseIdentifier("EmptyCell", forIndexPath: indexPath)
                return emptyCell
            }
            
            let level = structure.levels[levelRow]
            spotsCircleCollectionCell.spotsCircleView.countLabel.text = "\(level.available)"
            spotsCircleCollectionCell.spotsCircleView.titleLabel.text = "\(level.name)".uppercaseString
            spotsCircleCollectionCell.spotsCircleView.spotsCircleView.setCapacityLevel(CGFloat(level.available), outOfTotalCapacity: CGFloat(level.total))
            spotsCircleCollectionCell.spotsCircleView.spotsCircleView.animateCircle(Double(self.indexPath.row) * 0.35 + Double(levelRow) * 0.15)
            
            return levelCell

        }
    }
    
    func setCollectionViewStructure(structure : Structure, atIndexPath indexPath : NSIndexPath) {
        self.indexPath = indexPath
        
        if collectionView.delegate == nil {
            collectionView.rx_setDelegate(self)
            structureObserver
                .asObservable()
                .bindTo(collectionView.rx_itemsWithDataSource(dataSource))
                .addDisposableTo(db)
        }
        
        setLevelsCollectionViewDataSource(structure)
            .subscribeNext { (section) in
                self.structureObserver.value = section
            }
            .addDisposableTo(db)
    }
    
    private func setLevelsCollectionViewDataSource(structure : Structure) -> Observable<[SectionModel<Structure, Level>]> {
        return Observable.create { observer -> Disposable in
            let section = [SectionModel(model: structure, items: structure.levels)]
            observer.onNext(section)
            observer.onCompleted()
            return AnonymousDisposable { }
        }
    }
    
    //MARK: - CollectionView Delegate
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        let cvWidth = collectionView.bounds.width / 5
        return cvWidth - 50
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

}
