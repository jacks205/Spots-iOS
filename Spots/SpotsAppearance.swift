//
//  SpotsAppearance.swift
//  Spots
//
//  Created by Mark Jackson on 4/3/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//
import UIKit

struct SpotsAppearance {
    static let Background = UIColor(red:0.09, green:0.11, blue:0.15, alpha:1.00)
    struct Button {
        static let Selected = UIColor(red:0.18, green:0.84, blue:0.51, alpha:1.00)
        static let Unselected = UIColor(red:0.20, green:0.22, blue:0.25, alpha:1.00)
    }
    struct Cell {
        static let Selected = UIColor(red:0.85, green:0.85, blue:0.85, alpha:0.04)
    }
    struct Circle {
        static let Base = UIColor(red:0.14, green:0.19, blue:0.26, alpha:1.0)
        static let Red = UIColor(red:0.89, green:0.26, blue:0.37, alpha:1.0)
        static let Green = UIColor(red:0.10, green:0.74, blue:0.61, alpha:1.0)
        static let Yellow = UIColor(red:1.00, green:0.92, blue:0.25, alpha:1.0)
        
    }
    
    struct Today {
        static let Base = UIColor(white: 1, alpha: 0.1)
    }
}
