//
//  SpotsTodayButton.swift
//  Spots
//
//  Created by Mark Jackson on 4/4/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//

import UIKit

@IBDesignable class SpotsTodayButton: UIButton {
    override func drawRect(rect: CGRect) {
        UIColor(white: 1, alpha: 0.4).setFill()
        let path = UIBezierPath(roundedRect: CGRectInset(self.bounds, 0.5, 0.5), cornerRadius: 3)
        path.fill()
    }
}
