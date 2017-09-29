//
//  UtilityFunctionsTests.swift
//  bierjohannTests
//
//  Created by Kohler Manuel on 25.09.17.
//  Copyright © 2017 Manuel Kohler. All rights reserved.
//

import XCTest
@testable import bierjohann

class UtilityFunctionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
 
    }
    
    func testExtractString() {
        let htmlString = "<h3 class=\"slider__element--title\">Schlappeseppel </h3>"
        XCTAssertEqual("Schlappeseppel", extractString(s: htmlString))
    }

    func testGetTimestamp() {
        // TODO how Do I test for localized date style?
        //let dateFormatter = DateFormatter()
        //        XCTAssertEqual("", get_timestamp())
        
    }

    func testPrepareStringForURLSearch () {
        XCTAssertEqual("some%20string", prepareStringForURLSearch(s: "some string"))
    }
    
    func testReplaceAmp() {
        XCTAssertEqual("a&b", replaceAmp(aString: "a&amp;b"))
    }
    
    
    func testReplaceAmpForSearch() {
        XCTAssertEqual("this is a string an %26 in it", replaceAmpForSearch(s: "this is a string an & in it"))
    }
    

    func testSavedAndLoadBeer() {
        
        let brand = "Braukollektiv"
        
        var beers = [Beer]()
        let zeroRatingBeer = Beer.init(runningNumber: 1, brand: brand , type: "Dolly", ratingValue: 0.0, ratingCount: 1, new: true, timestamp: 100000)
        let greatRatingBeer = Beer.init(runningNumber: 2, brand: brand, type: "Horst", ratingValue: 5.0, ratingCount: 100, new: true, timestamp: 20000)

        beers.append(zeroRatingBeer!)
        beers.append(greatRatingBeer!)
        XCTAssertEqual(2, beers.count)

//        saveBeers(beers: beers)
//        let oldBeers = NSKeyedUnarchiver.unarchiveObject(withFile: Beer.ArchiveURL.path) as? [Beer]!
//        XCTAssertEqual(2,oldBeers?.count)
        
//        XCTAssertEqual(oldBeers![1].brand, brand)
    }

    func testDiffBeers() {
        
        var savedBeers = [Beer]()
        let Beer1 = Beer.init(runningNumber: 1, brand: "B1" , type: "Dolly", ratingValue: 0.0, ratingCount: 1, new: true, timestamp: 100000)
        let Beer2 = Beer.init(runningNumber: 2, brand: "B2", type: "Horst", ratingValue: 5.0, ratingCount: 100, new: true, timestamp: 20000)
        savedBeers.append(Beer1!)
        savedBeers.append(Beer2!)
        
        var newBeers = [Beer]()
        let newBeer1 = Beer.init(runningNumber: 1, brand: "NEWB1" , type: "NEWDolly", ratingValue: 0.0, ratingCount: 1, new: true, timestamp: 100000)
        let newBeer2 = Beer.init(runningNumber: 2, brand: "B2", type: "Horst", ratingValue: 5.0, ratingCount: 100, new: true, timestamp: 20000)
        newBeers.append(newBeer1!)
        newBeers.append(newBeer2!)

        let diffList = diffBeers(savedBeers: savedBeers, newBeers: newBeers)
        XCTAssertEqual([0], diffList)

    }
    
}
