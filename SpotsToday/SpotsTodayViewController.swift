//
//  TodayViewController.swift
//  SpotsToday
//
//  Created by Mark Jackson on 4/4/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//

import UIKit
import NotificationCenter
import RxCocoa
import RxSwift
import RxDataSources

class SpotsTodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var noSchoolSelectedView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var updatedLabel: UILabel!
    @IBOutlet weak var addSchoolBtn: SpotsTodayButton!
    
    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Structure>>()

    var provider : SpotsAPIProvider = SpotsProvider
    
    let db = DisposeBag()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard SpotsSharedDefaults.objectForKey("school") != nil else {
            setupAndShowSelectSchoolView()
            return
        }

        setupAndShowCollectionView()
        
    }
    
    func setupAndShowSelectSchoolView() {
        addSchoolBtn
            .rx_tap
            .subscribeNext {
                self.extensionContext?.openURL(NSURL(string: "AppUrlType://home")!, completionHandler: nil)
            }
            .addDisposableTo(db)
        
        //School is not chosen
        //...
        //Hide: collectionView, updateLabel
        //Show: noSchoolSelectedView
        noSchoolSelectedView.hidden = false
        updatedLabel.hidden = true
        collectionView.hidden = true
        
        //Set preferred length to 60 (smallest height we want)
        preferredContentSize = CGSize(width: 0, height: 60)
    }
    
    func setupAndShowCollectionView() {
        noSchoolSelectedView.hidden = true
        collectionView.hidden = false
        updatedLabel.hidden = false
        
        collectionView.delegate = self
        
        preferredContentSize = CGSize(width: 0, height: 173)
        
        dataSource.cellFactory = { (_, collectionView, indexPath, structure) in
            guard structure.name != nil else {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("EmptyCell", forIndexPath: indexPath)
                return cell
            }
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TodayCell", forIndexPath: indexPath)
            if let todayCell = cell as? SpotsTodayCollectionViewCell {
                todayCell.spotsCircleView.setCapacityLevel(CGFloat(structure.available), outOfTotalCapacity: CGFloat(structure.total))
                todayCell.amountLabel.text = "\(structure.available)"
                todayCell.titleLabel.text = structure.name.capitalizedString
                todayCell.spotsCircleView.animateCircle(0.35)
                
            }
            return cell
        }
        
        getParkingDataFromProvider()
            .subscribe { event in
                self.parseNetworkEvent(event)
            }
            .addDisposableTo(db)
    }
    
    //MARK: - Spots Requests
    
    private func getParkingDataFromProvider() -> Observable<SpotsResponse> {
        return SpotsAPI.getSpotsData(provider)
    }
    
    private func setStructuresDataSource(response : SpotsResponse) -> Observable<[SectionModel<String, Structure>]> {
        return Observable.create { observer -> Disposable in
            var structures = response.structures
            if response.structures.count % 2 == 1 {
                structures.append(Structure())
            }
            let section = [SectionModel(model: "", items: structures)]
            observer.onNext(section)
            observer.onCompleted()
            return AnonymousDisposable { }
        }
    }
    
    private func parseNetworkEvent(event : Event<SpotsResponse>) {
        switch event {
        case .Next(let res):
            setStructuresDataSource(res)
                .bindTo(collectionView.rx_itemsWithDataSource(dataSource))
                .addDisposableTo(self.db)
            updatedLabel.text = "Updated \(timeAgoSinceDate(res.lastUpdatedDate!, numericDates: true))"
            break
        case .Error(let err):
            print(err)
            break
        case .Completed:
            break
        }
    }
    
    //MARK: - Today Extension Methods
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        //Change inset based on screen size
        //Must line up to the first letter of the title of extension
        if view.bounds.width > 320 {
            return UIEdgeInsetsMake(0, 45, 0, 0)
        }
        return UIEdgeInsetsMake(0, 20, 0, 0)
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}


extension SpotsTodayViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
}
