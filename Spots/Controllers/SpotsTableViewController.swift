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

class SpotsTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var structures : Variable<[Structure]> = Variable([])
    var refreshControl : UIRefreshControl?
    var provider : SpotsAPIProvider = SpotsProvider
    
    let activityIndicator = ActivityIndicator()
    let db = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
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
            
        setupTableView()
        setupRefreshControl()
    }
    
    private func setupTableView() {
        tableView
            .rx_setDelegate(self)
            .addDisposableTo(db)
        
        structures.asObservable()
            .bindTo(tableView.rx_itemsWithCellIdentifier("Cell", cellType: SpotsTableViewCell.self)) { (row, structure, cell) in
                cell.selectionStyle = .None
                cell.title.text = structure.name.capitalizedString
                cell.totalSpots.text = "\(structure.available) spots available"
            }
            .addDisposableTo(db)
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        
        refreshControl?.rx_controlEvent(.ValueChanged)
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
        
        tableView.insertSubview(refreshControl!, atIndex: 0)
    }

    //MARK: - Spots Requests
    
    private func getParkingDataFromProvider() -> Observable<SpotsResponse> {
        return SpotsAPI.getSpotsData(provider)
    }
    
    private func parseNetworkEvent(event : Event<SpotsResponse>) {
        switch event {
        case .Next(let res):
            self.structures.value = res.structures
            self.refreshControl?.attributedTitle = self.getLastUpdatedAttributedString("Updated " + timeAgoSinceDate(res.lastUpdatedDate!, numericDates: true))
            break
        case .Error(let err):
            print(err)
            break
        case .Completed:
            break
        }
    }
    
    //MARK: - Helper Methods
    private func getLastUpdatedAttributedString(string : String) -> NSAttributedString {
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
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let spotsCell = cell as? SpotsTableViewCell {
            spotsCell.setCollectionViewDataSourceDelegate(self, withDelegate: self, atIndexPath: indexPath)
        }
    }
    
}

extension SpotsTableViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        let cvWidth = collectionView.bounds.width / 5
        return cvWidth - 50
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let levelCell : UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("LevelCell", forIndexPath: indexPath)
        
        guard let spotsCollectionCell = collectionView as? SpotsIndexedCollectionView, let spotsCircleCollectionCell = levelCell as? SpotsCircleCollectionViewCell else {
            return levelCell
        }
        
        let row = spotsCollectionCell.indexPath.row
        let levelRow = indexPath.row
        let structure = structures.value[row]
        
        guard levelRow < structure.levels.count else {
            let emptyCell = collectionView.dequeueReusableCellWithReuseIdentifier("EmptyCell", forIndexPath: indexPath)
            return emptyCell
        }
        
        let level = structure.levels[levelRow]
        spotsCircleCollectionCell.spotsCircleView.countLabel.text = "\(level.available)"
        spotsCircleCollectionCell.spotsCircleView.titleLabel.text = "LEVEL \(level.name)"
        spotsCircleCollectionCell.spotsCircleView.spotsCircleView.setCapacityLevel(CGFloat(level.available), outOfTotalCapacity: CGFloat(level.total))
        spotsCircleCollectionCell.spotsCircleView.spotsCircleView.animateCircle(Double(row) * 0.35 + Double(levelRow) * 0.15)
        
        return levelCell
    }
    
}
