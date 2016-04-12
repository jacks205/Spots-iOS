//
//  SpotsSchoolSelectionViewController.swift
//  Spots
//
//  Created by Mark Jackson on 4/3/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SpotsSchoolSelectionViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var letsGoButton: UIButton!
    
    let db = DisposeBag()
    
    var schools : Variable<[School]> = Variable([.CU, .CSUF])
    var schoolSelected : Variable<Bool> = Variable(false)
    var indexSelected : Variable<NSIndexPath> = Variable(NSIndexPath())
    
    override func viewDidLoad() {
        view.backgroundColor = SpotsAppearance.Background
        super.viewDidLoad()
        setupTableView(schools)
        setupLetsGoButton()
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .None
    }
    
    func setupTableView(schools : Variable<[School]>) {
        tableView
            .rx_setDelegate(self)
            .addDisposableTo(db)
        
        schools
            .asObservable()
            .bindTo(tableView.rx_itemsWithCellIdentifier("SchoolCell", cellType: SpotsSchoolTableViewCell.self)) { (row, school, cell) in
                if row == schools.value.count - 1 { cell.isBottomCell = true }
                cell.schoolTextLabel.text = school.rawValue
            }
            .addDisposableTo(db)
        
        tableView
            .rx_itemSelected
            .subscribeNext { (indexPath) in
                if let cell =  self.tableView.cellForRowAtIndexPath(indexPath) as? SpotsSchoolTableViewCell {
                    cell.selected = !self.schoolSelected.value
                    self.schoolSelected.value = !self.schoolSelected.value
                }
                self.indexSelected.value = indexPath
            }
            .addDisposableTo(db)
        
        tableView
            .rx_itemDeselected
            .subscribeNext { (indexPath) in
                self.schoolSelected.value = false
            }
            .addDisposableTo(db)
        
        
    }
    
    func setupLetsGoButton() {
        letsGoButton
            .rx_tap
            .subscribeNext {
                self.schools
                    .asObservable()
                    .throttle(0.1, scheduler: MainScheduler.instance)
                    .subscribeNext { schools in
                    let selectedSchool = schools[self.indexSelected.value.row]
                    self.saveSchoolToUserDefaults(selectedSchool)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let schoolType = SpotsVCType.getTypeFromSchool(selectedSchool)
                    if let spotsVc = storyboard.instantiateViewControllerWithIdentifier(schoolType.rawValue) as? SpotsTableViewController {
                        spotsVc.school = selectedSchool
                        self.navigationController?.pushViewController(spotsVc, animated: true)
                    }
                }
                .addDisposableTo(self.db)
            }
            .addDisposableTo(db)

        schoolSelected
            .asObservable()
            .bindTo(letsGoButton.rx_enabled)
            .addDisposableTo(db)
        
        schoolSelected
            .asObservable()
            .subscribeNext { (isSelected) in
                if isSelected {
                    self.letsGoButton.backgroundColor = SpotsAppearance.Button.Selected
                    self.letsGoButton.setTitleColor(UIColor(white: 1, alpha: 1), forState: .Normal)
                } else {
                    self.letsGoButton.backgroundColor = SpotsAppearance.Button.Unselected
                    self.letsGoButton.setTitleColor(UIColor(white: 1, alpha: 0.27), forState: .Normal)
                }
            }
            .addDisposableTo(db)
    }
    
    func saveSchoolToUserDefaults(school : School) {
        NSUserDefaults.standardUserDefaults().setObject(school.rawValue, forKey: "SettingsBundleSchoolSelected")
        SpotsSharedDefaults.setObject(school.rawValue, forKey: "school")
    }

}
