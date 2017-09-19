//
//  bierjohannTests.swift
//  bierjohannTests
//
//  Created by Kohler Manuel on 18.06.17.
//  Copyright © 2017 Kohler  Manuel. All rights reserved.
//

import XCTest
@testable import bierjohann

class bierjohannTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    //MARK: Beer Class Tests
    
    func testBeerInitializationSucceeds() {
        let zeroRatingBeer = Beer.init(brand: "Braukollektiv", type: "Dolly", ratingValue: 0.0, ratingCount: 1)
        XCTAssertNotNil(zeroRatingBeer)

        let positiveRatingBeer = Beer.init(brand: "Braukollektiv", type: "Dolly", ratingValue: 5.0, ratingCount: 5000)
        XCTAssertNotNil(positiveRatingBeer)
    }
    
    func testBeerInitializationFails() {
        let negativeRatingBeer = Beer.init(brand: "Braukollektiv", type: "Dolly", ratingValue: -3.0, ratingCount: 1)
        XCTAssertNil(negativeRatingBeer)

        let emptyBrandRatingBeer = Beer.init(brand: "", type: "Dolly", ratingValue: 4.0, ratingCount: 1)
        XCTAssertNil(emptyBrandRatingBeer)
        
        let emptyTypeRatingBeer = Beer.init(brand: "Braukollektiv", type: "", ratingValue: 4.0, ratingCount: 1)
        XCTAssertNil(emptyTypeRatingBeer)

        let emptyBrandTypeRatingBeer = Beer.init(brand: "", type: "", ratingValue: 4.0, ratingCount: 1)
        XCTAssertNil(emptyBrandTypeRatingBeer)
        
        let largeBrandRatingBeer = Beer.init(brand: "", type: "Dolly", ratingValue: 6.0, ratingCount: 1)
        XCTAssertNil(largeBrandRatingBeer)


    }
    
}
