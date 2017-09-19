//
//  Beer.swift
//  bierjohann
//
//  Created by Kohler Manuel on 19.09.17.
//  Copyright © 2017 Manuel Kohler. All rights reserved.
//

import UIKit


class Beer {
    
    //MARK: Properties
    var brand : String
    var type : String
    var ratingValue: Float
    var ratingCount: Int
    
    
    //MARK: Initialization
    
    init?(brand: String, type: String, ratingValue: Float, ratingCount: Int) {
        
        guard !brand.isEmpty && !type.isEmpty else {
            return nil
        }
        
        guard (ratingValue >= 0.0) && (ratingValue <= 5.0) else {
            return nil
        }
        
        guard (ratingCount >= 0) else {
            return nil
        }

        
        self.brand = brand
        self.type = type
        self.ratingValue = ratingValue
        self.ratingCount = ratingCount
        
    }
}
