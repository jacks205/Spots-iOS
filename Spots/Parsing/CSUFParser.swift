//
//  CSUFParser.swift
//  Spots
//
//  Created by Mark Jackson on 4/11/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//

import RxSwift
import ObjectMapper
import Kanna

enum ParsingError : ErrorType {
    case Error
}

class CSUFParser {
    
    static func parseCSUFData(data : NSData) -> Observable<SpotsResponse> {
        return Observable<SpotsResponse>.create { obs -> Disposable in
            let dataString = String(data: data, encoding: NSUTF8StringEncoding)
            if let doc = Kanna.HTML(html: dataString!, encoding: NSUTF8StringEncoding) {
                let set = doc.css("tr")
                let structures = set
                    .filter { $0.text != nil }
                    .map { element -> [String : AnyObject] in
                        return parseXMLElement(element)
                    }
                let json = [
                    "structures" : structures
                ]
                if let spotsResponse = Mapper<SpotsResponse>().map(json) {
                    obs.onNext(spotsResponse)
                } else {
                    obs.onError(ParsingError.Error)
                }
            } else {
                obs.onError(ParsingError.Error)
            }
            obs.onCompleted()
            return AnonymousDisposable { }
        }
        
    }
    
    private static func parseXMLElement(element : XMLElement) -> [String : AnyObject] {
        let structures = element.text!.characters
            .split { $0 == "\r\n" }
            .map(String.init)
            .filter { !$0.containsString("\t") && !$0.containsString("More") && !$0.containsString("Total") }
            .map { $0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) }
            .filter { $0 != "" }
        let name = structures[0]
        let total = Int(structures[1])!
        let lastUpdated = structures[2]
        let date = lastUpdated.dateWithFormat("M/dd/yyyy h:mm:s a", timezone: "PST")
        let lastUpdatedISO = date.formattedString("yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone: "UTC")
        let available = Int(structures[3])!
        let structure : [String : AnyObject] = [
            "name" : name,
            "available" : available,
            "total" : total,
            "lastUpdated" : lastUpdatedISO
        ]
        return structure
    }
    
    
}
