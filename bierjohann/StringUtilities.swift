//
//  StringUtilities.swift
//  bierjohann
//
//  Created by Kohler Manuel on 22.10.17.
//  Copyright © 2017 Manuel Kohler. All rights reserved.
//

import Foundation
import os.log


func countryCodeToEmoji(country:String) -> String {
    let base : UInt32 = 127397
    var s = ""
    for v in country.unicodeScalars {
        s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
    }
    return String(s)
}


func extractString(s: String) -> String {
    // expect s as <h3 class=\"slider__element--title\">Schlappeseppel </h3>
    let rawString = s.components(separatedBy: ">")[1].components(separatedBy: "<")[0]
    let cleanedString = rawString.html2String
    return cleanedString
}


func prepareStringForURLSearch (s: String) -> String{
    return s.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
}

