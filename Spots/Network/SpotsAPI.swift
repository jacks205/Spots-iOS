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
import Moya_ObjectMapper

//MARK: - Shared Defaults

let SpotsSharedDefaults = NSUserDefaults(suiteName: SPOTS_SUITE_NAME)!


//MARK: - Spots API

class SpotsAPI {
    
    class func getSpotsData(provider : SpotsAPIProvider) ->  Observable<SpotsResponse> {
        return provider.request(.Parking)
            .mapObject(SpotsResponse)
    }
    
}

// MARK: - Provider setup
typealias SpotsAPIProvider = RxMoyaProvider<Spots>

let SpotsProvider = SpotsAPIProvider()

// MARK: - Provider support

public enum Spots {
    case Parking
}

extension Spots : TargetType {
    public var baseURL : NSURL {
        return NSURL(string: CHAPMAN_UNIVERSITY_URL)!
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
