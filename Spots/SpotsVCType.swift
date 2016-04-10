//
//  SpotsVCType.swift
//  Spots
//
//  Created by Mark Jackson on 4/7/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//
enum SpotsVCType : String {
    case NoLevels, Levels
    
    static func getTypeFromSchool(school : School) -> SpotsVCType {
        switch school {
        case .CU:
            return .Levels
        default:
            return .NoLevels
        }
    }
}
