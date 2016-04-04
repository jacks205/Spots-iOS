//
//  SpotsTests.swift
//  SpotsTests
//
//  Created by Mark Jackson on 3/31/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//

import XCTest
@testable import Spots

class SpotsTests: XCTestCase {
    
    var sut : SpotsTableViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let nvc = storyboard.instantiateInitialViewController() as? UINavigationController
        sut = nvc?.viewControllers.first as? SpotsTableViewController
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        sut.viewDidLoad()
        
        
    }
    
}
