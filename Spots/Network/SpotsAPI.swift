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
import ObjectMapper

//MARK: - Shared Defaults

let SpotsSharedDefaults = NSUserDefaults(suiteName: SPOTS_SUITE_NAME)!

// MARK: - Provider setup
let CUSpotsProvider = RxMoyaProvider<CUSpots>()
let CSUFSpotsProvider = RxMoyaProvider<CSUFSpots>()

func getCUParkingData() -> Observable<SpotsResponse> {
    return CUSpotsProvider
        .request(.Parking)
        .mapObject(SpotsResponse)
}

func getCSUFParkingData() -> Observable<SpotsResponse> {
    return CSUFSpotsProvider
        .request(.Parking)
        .flatMapLatest { response in
            return CSUFParser.parseCSUFData(response.data)
        }
}

// MARK: - Provider support

public enum CUSpots {
    case Parking
}

extension CUSpots : TargetType {
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

public enum CSUFSpots {
    case Parking
}

extension CSUFSpots : TargetType {
    public var baseURL : NSURL {
        return NSURL(string: CSUF_URL)!
    }
    
    public var path: String {
        switch self {
        case .Parking:
            return "/parkinglotcounts/mobile.aspx"
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
