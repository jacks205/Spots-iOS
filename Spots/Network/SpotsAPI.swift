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
import Kanna

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

//TODO: MOVE

func getCSUFParkingData(db : DisposeBag) -> Observable<SpotsResponse> {
    return Observable<SpotsResponse>.create { obs -> Disposable in
        CSUFSpotsProvider
            .request(.Parking)
            .subscribeNext { response in
                let dataString = String(data: response.data, encoding: NSUTF8StringEncoding)
                let doc = Kanna.HTML(html: dataString!, encoding: NSUTF8StringEncoding)!
                let set = doc.css("tr")
                var elements : [[String : AnyObject]] = []
                for element in set where element.text != nil {
                    let structures = element.text!.characters
                        .split { $0 == "\r\n" }
                        .map(String.init)
                        .filter { !$0.containsString("\t") && !$0.containsString("More") && !$0.containsString("Total") }
                        .map { $0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) }
                        .filter { $0 != "" }
                    let name = structures[0]
                    let lastUpdated = structures[2] as? String
                    let date = lastUpdated!.dateWithFormat("M/dd/yyyy h:mm:s a", timezone: "PST")
                    let lastUpdatedISO = date.formattedString("yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone: "UTC")
                    let available = Int(structures[3])!
                    let total = Int(structures[1])!
                    let structure : [String : AnyObject] = [
                        "name" : name,
                        "available" : available,
                        "total" : total,
                        "lastUpdated" : lastUpdatedISO
                    ]
                    elements.append(structure)
                }
                let json = [
                    "structures" : elements
                ]
                if let spotsResponse = Mapper<SpotsResponse>().map(json) {
                    obs.onNext(spotsResponse)
                }
                obs.onCompleted()
            }
            .addDisposableTo(db)
        return AnonymousDisposable { }
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
