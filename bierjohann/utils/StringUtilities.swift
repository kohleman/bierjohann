//
//  StringUtilities.swift
//  bierjohann
//
//  Created by Kohler Manuel on 22.10.17.
//  Copyright © 2017 Manuel Kohler. All rights reserved.
//

import Foundation
import os.log
import SwiftSoup


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


func extractEvents(eventFirst: Event) -> [Event] {

    var events = [Event]()
    var event: Event
    var eventId = eventFirst.id + 1
    var previousEvent = eventFirst
    
//    guard var previousEvent = Event(id: 0, title: "Title", date: "Date", body: "body", html: "rawHTML")
//        else {
//            fatalError("Unable to instantiate dummy Event!")
//    }
    
    while (true) {
        let eventAddress = "https://www.bierjohann.ch/news/p\(eventId)/?show=1"
        let myHTMLString = getURLSite(webaddress: eventAddress)
        event = parseEvents(html: myHTMLString)
        
        // need to use the title as any id works and does not return an error
        if (event.title == previousEvent.title) {
            break
        }
        previousEvent = event
        events.append(event)
        eventId += 1
    }
    os_log("%@", type: .debug, "Got \(events.count) new events.")

    // sort the events by id in desc order
    return events.sorted(by: { $0.id > $1.id })
}


func parseEvents(html: String) -> Event {
    
    let event = Event()

    do {
        let doc: Document = try SwiftSoup.parse(html)
        
        event.html = try doc.text()
        
        let article: Element = try! doc.select("article").first()!
        let id = Int(try! article.attr("data-id"))!
        event.id = id
        os_log("%@", type: .debug, "Parsed event with id \(id).")

        let h2: Element = try! article.select("h2").first()!
        event.title = try! h2.text()

        let h3: Element = try! article.select("h3").first()!
        event.date = try! h3.text()

        let pElements: Elements = try! article.select("p")
        
        for p: Element in pElements.array(){
            let pText: String = try p.text()
            event.body += pText
        }
        return event
        
    } catch Exception.Error(let type, let message){
        print(type)
        print(message)
        
    } catch{
        print("error")
    }
    return event
}
