//
//  UtilityFunctions.swift
//  bierjohann
//
//  Created by Kohler Manuel on 01.07.17.
//  Copyright © 2017 Kohler  Manuel. All rights reserved.
//

import Foundation
import UIKit


func extractString(s: String) -> String {
    // expect s as <h3 class=\"slider__element--title\">Schlappeseppel </h3>    
    let rawString = s.components(separatedBy: ">")[1].components(separatedBy: "<")[0]
    let cleanedString = replaceAmp(aString: rawString)
    return cleanedString.trimmingCharacters(in: .whitespacesAndNewlines)
}

func get_timestamp() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss dd.MM.yyyy"
    // not hardcoded, use the localized style
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    

    let date = Date()
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

    let d: Date? = dateFormatter.calendar.date(from: components)
    return dateFormatter.string(from: d!)
}

func prepareStringForURLSearch (s: String) -> String{
//    return s.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    return s.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
}


func getURLSite(webaddress: String) -> String {
    
    var myHTMLString: String = ""
    
    guard let myURL = URL(string: webaddress) else {
        print("Error: \(webaddress) doesn't seem to be a valid URL")
        return ("")
    }
    
    let myGroup = DispatchGroup()
    
    do {
        print("Do some async work...")
        myGroup.enter()
        myHTMLString = try String(contentsOf: myURL, encoding: .utf8)
    }
    catch let error {
        print("Error: \(error)")
    }
    myGroup.leave()
    myGroup.notify(queue: .main) {
        print("Finished all requests.")
    }
    
    return (myHTMLString)
}


func replaceAmp(aString: String) -> String {
    // dirty hack :-(
    return aString.replacingOccurrences(of: "&amp;", with: "&", options: .literal, range: nil)
}

func replaceAmpForSearch(s: String) -> String {
    return s.replacingOccurrences(of: "&", with: "%26", options: .literal, range: nil)
}



extension Date {
    // Usage print(Date().secondsSince1970)
    var secondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970).rounded())
    }
    
    init(seconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(seconds))
    }
}
