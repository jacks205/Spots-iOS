//
//  SpotsAPI.swift
//  Spots
//
//  Created by Mark Jackson on 4/1/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class SpotsAPI {
    
    class func getSpotsData() ->  Observable<SpotsResponse>{
        return SpotsProvider.request(.Parking)
            .mapObject(SpotsResponse)
    }
    
}

// MARK: - Provider setup

let SpotsProvider = RxMoyaProvider<Spots>()

// MARK: - Provider support

public enum Spots {
    case Parking
}

extension Spots : TargetType{
    public var baseURL : NSURL {
        return NSURL(string: SPOTS_API_URL)!
    }
    
    public var path: String {
        switch self {
        case .Parking:
            return "/latest-availabilities"
        }
    }
        
    public var method: Moya.Method {
        return .GET
    }
    
    public var parameters: [String: AnyObject]? {
        return nil
    }
    
    public var sampleData: NSData {
        switch self {
        case .Parking:
            return "Parking json data".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
}

public func url(route: TargetType) -> String {
    return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString
}
