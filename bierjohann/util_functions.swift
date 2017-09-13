//
//  extra_function.swift
//  bierjohann
//
//  Created by Kohler Manuel on 01.07.17.
//  Copyright © 2017 Kohler  Manuel (ID SIS). All rights reserved.
//

import Foundation


func extractString(s: String) -> String {
    return s.components(separatedBy: ">")[1].components(separatedBy: "<")[0]
}

func get_timestamp() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss dd.MM.yyyy"

    let date = Date()
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

    let d: Date? = dateFormatter.calendar.date(from: components)
    return dateFormatter.string(from: d!)
}

func prepareStringForURLSearch (s: String) -> String{    
    return s.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
}

