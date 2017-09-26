//
//  Beer.swift
//  bierjohann
//
//  Created by Kohler Manuel on 19.09.17.
//  Copyright © 2017 Manuel Kohler. All rights reserved.
//

import Foundation
import os.log

class Beer: NSObject, NSCoding {
    
    //MARK: Properties
    var runningNumber: Int
    var brand : String
    var type : String
    var ratingValue: Float
    var ratingCount: Int
    var new: Bool
    var timestamp: Int64
    
    //MARK: Types
    struct PropertyKey {
        static let runningNumber = "runningNumber"
        static let brand = "brand"
        static let type = "type"
        static let ratingValue = "ratingValue"
        static let ratingCount = "ratingCount"
        static let new = "new"
        static let timestamp = "timestamp"
    }
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("beers")

    
    //MARK: Initialization
    init?(runningNumber: Int, brand: String, type: String, ratingValue: Float, ratingCount: Int, new: Bool, timestamp: Int64) {
        
        guard !brand.isEmpty && !type.isEmpty else {
            return nil
        }
        
        guard (ratingValue >= 0.0) && (ratingValue <= 5.0) else {
            return nil
        }
        
        guard (ratingCount >= 0) else {
            return nil
        }

        self.runningNumber = runningNumber
        self.brand = brand
        self.type = type
        self.ratingValue = ratingValue
        self.ratingCount = ratingCount
        self.new = new
        self.timestamp = timestamp
        
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(runningNumber, forKey:PropertyKey.runningNumber)
        aCoder.encode(brand, forKey:PropertyKey.brand)
        aCoder.encode(type, forKey:PropertyKey.type)
        aCoder.encode(ratingValue, forKey:PropertyKey.ratingValue)
        aCoder.encode(ratingCount, forKey:PropertyKey.ratingCount)
        aCoder.encode(new, forKey:PropertyKey.new)
        aCoder.encode(timestamp, forKey: PropertyKey.timestamp)
    }
    
    // The convenience modifier means that this is a secondary initializer,
    // and that it must call a designated initializer from the same class (at the bottom).
    required convenience init?(coder aDecoder: NSCoder) {
        
        let runningNumber = aDecoder.decodeInteger(forKey: PropertyKey.runningNumber)

        // The brand is required. If we cannot decode a brand string, the initializer should fail.
        guard let brand = aDecoder.decodeObject(forKey: PropertyKey.brand) as? String else {
            if #available(iOS 10.0, *) {
                os_log("Unable to decode the name for a Beer object.", log: OSLog.default, type: .debug)
            } else {
                // Fallback on earlier versions
            }
            return nil
        }
        
        guard let type = aDecoder.decodeObject(forKey: PropertyKey.type) as? String else {
            if #available(iOS 10.0, *) {
                os_log("Unable to decode the name for a Beer object.", log: OSLog.default, type: .debug)
            } else {
                // Fallback on earlier versions
            }
            return nil
        }
       
        let ratingValue = aDecoder.decodeFloat(forKey: PropertyKey.ratingValue)
        let ratingCount = aDecoder.decodeInteger(forKey: PropertyKey.ratingCount)
        let new = aDecoder.decodeBool(forKey: PropertyKey.new)
        let timestamp = aDecoder.decodeInt64(forKey: PropertyKey.timestamp)

        // Must call designated initializer.
        self.init(runningNumber: runningNumber, brand: brand, type: type, ratingValue: ratingValue, ratingCount: ratingCount, new: new, timestamp: timestamp)
    }
    
    // Needed for comparison of two instances but currently unused
    public static func ==(lhs: Beer, rhs: Beer) -> Bool{
        return
                lhs.brand == rhs.brand &&
                lhs.type == rhs.type
    }
}
