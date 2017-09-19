//
//  extra_function.swift
//  bierjohann
//
//  Created by Kohler Manuel on 01.07.17.
//  Copyright © 2017 Kohler  Manuel. All rights reserved.
//

import Foundation


func extractString(s: String) -> String {
    return s.components(separatedBy: ">")[1].components(separatedBy: "<")[0]
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
    return s.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
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


