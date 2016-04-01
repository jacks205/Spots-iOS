//
//  Structure.swift
//  Spots
//
//  Created by Mark Jackson on 4/1/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//

import Foundation
import ObjectMapper

struct SpotsResponse: Mappable {
    
    var structures : [Structure]!
    var lastUpdated : String!
    var lastUpdatedISO : String!
    var _id : String!
    
    var lastUpdatedDate : NSDate? {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
        return dateFormatter.dateFromString(lastUpdatedISO)
    }
    
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        structures <- map["structures"]
        lastUpdated <- map["lastUpdated"]
        lastUpdatedISO <- map["lastUpdatedISO"]
        _id <- map["_id"]
    }
    
}

struct Structure: Mappable {
    
    var levels : [Level]!
    var available : Int!
    var name : String!
    var nickname : String!
    var total : Int!
    
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        levels <- map["levels"]
        available <- map["available"]
        name <- map["name"]
        nickname <- map["nickname"]
        total <- map["total"]
    }
    
    

}

struct Level : Mappable {
    
    var available : Int!
    var name : String!
    var total : Int!
    
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        available <- map["available"]
        name <- map["name"]
        total <- map["total"]
    }
    
}