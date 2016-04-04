//
//  SpotsSchoolTableViewCell.swift
//  Spots
//
//  Created by Mark Jackson on 4/4/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//

import UIKit

class SpotsSchoolTableViewCell : UITableViewCell {
    @IBOutlet weak var schoolTextLabel: UILabel!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    override func drawRect(rect: CGRect) {
        UIColor(white: 1, alpha: 0.09).setStroke()
        
        let topPath = UIBezierPath()
        topPath.lineWidth = 1
        topPath.moveToPoint(CGPoint(x: 0, y: 1))
        topPath.addLineToPoint(CGPoint(x: rect.width, y: 1))
        topPath.stroke()
        
        let bottomPath = UIBezierPath()
        bottomPath.lineWidth = 1
        bottomPath.moveToPoint(CGPoint(x: 0, y: rect.height - 1))
        bottomPath.addLineToPoint(CGPoint(x: rect.width, y: rect.height - 1))
        bottomPath.stroke()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        if selected {
            selectedBackgroundView = UIView() //Don't know why this needs to be created each time
            selectedBackgroundView?.backgroundColor = UIColor(white:1, alpha:0.04)
            selectedImageView.image = UIImage(named: "check")
        } else {
            selectedBackgroundView = nil
            selectedImageView.image = UIImage(named: "empty")
        }
        super.setSelected(selected, animated: animated)
    }
}
