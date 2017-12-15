//
//  Constants.swift
//  bierjohann
//
//  Created by Kohler Manuel on 22.10.17.
//  Copyright © 2017 Manuel Kohler. All rights reserved.
//

import Foundation
import UIKit


struct Constants {
    static let BIERJOHANN_BROWN = UIColor(red:0.46, green:0.09, blue:0.02, alpha:1.0)
    static let GOOGLE_SEARCH_STRING = "https://www.google.com/search?q="
    
    static let DAY_IN_SECONDS = 3600*24
    static let BIERJOHANN_URL = "https://www.bierjohann.ch/"

    static let RATE_BEER_KEY: [UInt8] = [15, 59, 34, 1, 33, 39, 86, 39, 57, 25, 19, 20, 39, 99, 32, 51, 44, 87, 36, 107, 2, 121, 6, 3, 1, 29, 60, 23, 48, 64, 75, 39, 97, 106, 37, 69]
    
    // Testing API
    //static let RATE_BEER_API_ADDRESS: String = "https://api.r8.beer/v1/api/graphql/"
    
    // productive API
    static let RATE_BEER_API_ADDRESS: String = "https://api.ratebeer.com/v1/api/graphql"
}
