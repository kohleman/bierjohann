//
//  UtilityFunctions.swift
//  bierjohann
//
//  Created by Kohler Manuel on 01.07.17.
//  Copyright © 2017 Kohler  Manuel. All rights reserved.
//

// For variable interpolation in os_log
// defined here:
//https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html
//For Strings u use %@
//For int  u use %i
//For float u use %f
//For double u use %lf


import Foundation
import UIKit
import os.log


//func enrichBeersWithRatings (beer: Beer, apolloClient: ApolloClient) {

//    print("enrichBeersWithRatingsCC \(countryCodeToEmoji(country: beer.countryCode))")
//    print("enrichBeersWithRatingsBrand \(beer.brand)")
//    print("enrichBeersWithRatingsratingCount \(beer.ratingCount)")
//    print("enrichBeersWithRatingsoverall Score \(beer.overallScore)")
    
//}


func getTimestamp() -> String {
    let dateFormatter = DateFormatter()
    // not hardcoded, use the localized style
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium    

    let date = Date()
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

    let d: Date? = dateFormatter.calendar.date(from: components)
    return dateFormatter.string(from: d!)
}



func getURLSite(webaddress: String) -> String {
    
    var myHTMLString: String = ""
    
    guard let myURL = URL(string: webaddress) else {
        os_log("Error: %@ doesn't seem to be a valid URL", log: OSLog.default, type: .debug, webaddress)
        return ("")
    }
    
    let myGroup = DispatchGroup()
    
    do {
        os_log("Do some async work...", log: OSLog.default, type: .debug)

        myGroup.enter()
        myHTMLString = try String(contentsOf: myURL, encoding: .utf8)
    }
    catch let error {
        os_log("Error: %@", log: OSLog.default, type: .debug, error as CVarArg)

    }
    myGroup.leave()
    myGroup.notify(queue: .main) {
        os_log("Finished all requests.", log: OSLog.default, type: .debug)
    }
    
    return (myHTMLString)
}


func extractAndInitBeers(webaddress: String) -> [Beer]{
        
    var aBrand: String = ""
    var aName: String = ""
    var counter: Int = 1
    
    var beers = [Beer]()
    
    let myHTMLString = getURLSite(webaddress: webaddress)
    
    myHTMLString.enumerateLines { line, _ in
        if line.contains("slider__element--title") {
            aBrand = extractString(s: line)
        }
        
        if line.contains("slider__element--text") {
            aName = extractString(s: line)
            
            guard let aBeer = Beer(runningNumber: counter, brand: aBrand, type: aName, ratingValue: 0.0, ratingCount: 0, new: true, timestamp: 0, abv: 0.0, overallScore: 0.0) else {
                fatalError("Unable to instantiate class Beer with " + aBrand)
            }
            
            beers.append(aBeer)
            counter += 1
        }
    }        
    return beers
    
}


/* Compares a list of beers against another list of beers and returns
 * a list of indices of the differing beers
 */
func diffBeers(savedBeers: [Beer], newBeers: [Beer]) -> [Int] {
    
    let now = Date().secondsSince1970
    
    let timeIndex = zip(newBeers, savedBeers).enumerated().filter() {
        (now - $1.1.timestamp) < Constants.DAY_IN_SECONDS * 2
        }.map{$0.0}

    for index in timeIndex {
        newBeers[index].new = false
        // save the timestamp when this was found as a new beer
        newBeers[index].timestamp = savedBeers[index].timestamp
    }
    
    let diffIndex = zip(newBeers, savedBeers).enumerated().filter() {
        $1.0.brand != $1.1.brand && $1.0.type != $1.1.type
        }.map{$0.0}
    
    if (diffIndex.count > 0) {
        print("New beers index:  \(diffIndex)")
    }
    
    for index in diffIndex {
        newBeers[index].new = false
        newBeers[index].timestamp = Date().secondsSince1970
    }
    
    return diffIndex
}


func harvestBeers(savedBeers: [Beer]) -> [Beer]{
    var beers = [Beer]()
    beers = extractAndInitBeers(webaddress: Constants.BIERJOHANN_URL)
    
    os_log("Got %i beers.", log: OSLog.default, type: .debug, beers.count)
    
    _ = diffBeers(savedBeers: savedBeers, newBeers: beers)
    saveBeers(beers: beers)
    return beers
}


func checkAppUpgraded() -> Bool {
    let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    let versionOfLastRun = UserDefaults.standard.object(forKey: "VersionOfLastRun") as? String
    
    os_log("Current App Version :%@", log: OSLog.default, type: .debug, currentVersion ?? "unknown")
    os_log("App Version on last run: %@", log: OSLog.default, type: .debug, versionOfLastRun ?? "unknown")

    var returnValue = false
    
    if versionOfLastRun == nil {
        // First start after installing the app
    } else if versionOfLastRun != currentVersion {
        // App was updated since last run
        returnValue = true
    } else {
        // nothing changed
        returnValue = false
    }
    UserDefaults.standard.set(currentVersion, forKey: "VersionOfLastRun")
    UserDefaults.standard.synchronize()

    return returnValue
}


// Template: how to see the caller of a function
func debug(file: String = #file, line: Int = #line, function: String = #function) -> String {
    return "\(file):\(line) : \(function)"
}


func roundOneDecimals(d: Double) -> Double {
    return Double(round(10*d)/10)
}

