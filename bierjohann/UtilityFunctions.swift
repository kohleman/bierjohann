//
//  UtilityFunctions.swift
//  bierjohann
//
//  Created by Kohler Manuel on 01.07.17.
//  Copyright © 2017 Kohler  Manuel. All rights reserved.
//

import Foundation
import UIKit
import os.log
import Apollo

let dayInSeconds = 3600*24
let myURLString = "https://www.bierjohann.ch/"


func testApollo(searchString: String, beer: Beer) -> Beer{
    let apollo = createApolloClient()
    
    apollo.fetch(query: BeerRatingQuery(q: searchString)) { (result, error) in
        guard let data = result?.data else { return }
        
        if (data.beerSearch?.items.isEmpty == false) {
            print(data.beerSearch?.items[0]?.name ?? "not existent")
//            print(data.beerSearch?.items[0]?.averageRating ?? "not existent")
//            print(data.beerSearch?.items[0]?.ratingCount)
//            print(data.beerSearch?.items[0]?.brewer?.country?.code ?? "Help me!")
            
            beer.ratingValue = Float((data.beerSearch?.items[0]?.averageRating)!)
            beer.ratingCount = (data.beerSearch?.items[0]?.ratingCount)!
            beer.countryCode = (data.beerSearch?.items[0]?.brewer?.country?.code)!
            
            print((data.beerSearch?.items[0]?.brewer?.country?.code)!)
            
        }
    }
    return beer
}


func extractString(s: String) -> String {
    // expect s as <h3 class=\"slider__element--title\">Schlappeseppel </h3>    
    let rawString = s.components(separatedBy: ">")[1].components(separatedBy: "<")[0]
    let cleanedString = rawString.html2String
    return cleanedString
}

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






func saveBeers(beers: [Beer]) {
    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(beers, toFile: Beer.ArchiveURL.path)
    
    if #available(iOS 10.0, *) {
        if isSuccessfulSave {
            os_log("Beers successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save beers...", log: OSLog.default, type: .error)
        }
    } else {
        // Fallback on earlier versions
    }
    
}

func loadBeers() -> [Beer]? {
    
    let fileExists = FileManager().fileExists(atPath: Beer.ArchiveURL.path)
    if fileExists {
        return (NSKeyedUnarchiver.unarchiveObject(withFile: Beer.ArchiveURL.path) as? [Beer])!
    }
    else {
        return [Beer]()
    }
}

func extractBeers(webaddress: String) -> [Beer]{
    
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
            
            guard let aBeer = Beer(runningNumber: counter, brand: aBrand, type: aName, ratingValue: 0.0, ratingCount: 0,
                                   new: true, timestamp: 0, countryCode: "") else {
                fatalError("Unable to instantiate class Beer with " + aBrand)
            }
            beers.append(aBeer)
            counter += 1
        }
    }
    return beers
}


func diffBeers(savedBeers: [Beer], newBeers: [Beer]) -> [Int] {
    
    //        beers[3].brand = "Beer4"
    //        beers[3].type = "T4"
    //        beers[3].timestamp = 1506438938 + 30000
    
    let now = Date().secondsSince1970
    
    let timeIndex = zip(newBeers, savedBeers).enumerated().filter() {
        (now - $1.1.timestamp) < dayInSeconds
        }.map{$0.0}
    
    if (timeIndex.count > 0) {
        print("Beer with new timestamp found \(timeIndex)")
    }
    
    for index in timeIndex {
        newBeers[index].new = false
        // save the timestamp when this was found as a new beer
        newBeers[index].timestamp = savedBeers[index].timestamp
    }
    
    let diffIndex = zip(newBeers, savedBeers).enumerated().filter() {
        $1.0.brand != $1.1.brand && $1.0.type != $1.1.type
        }.map{$0.0}
    
    if (diffIndex.count > 0) {
        print("New beer found \(diffIndex)")
    }
    
    for index in diffIndex {
        newBeers[index].new = false
        newBeers[index].timestamp = Date().secondsSince1970
    }
    
    return diffIndex
}


func harvestBeers(savedBeers: [Beer]) -> [Beer]{
    var beers = [Beer]()
    beers = extractBeers(webaddress: myURLString)
    print("Got \(beers.count) beers.")

    let savedBeers = loadBeers()
    _ = diffBeers(savedBeers: savedBeers!, newBeers: beers)
    saveBeers(beers: beers)
    return beers
}

// Country Code to Emoji flag
func flag(country:String) -> String {
    let base : UInt32 = 127397
    var s = ""
    for v in country.unicodeScalars {
        s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
    }
    return String(s)
}

