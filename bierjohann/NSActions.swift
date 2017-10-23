//
//  NSActions.swift
//  bierjohann
//
//  Created by Kohler Manuel on 22.10.17.
//  Copyright © 2017 Manuel Kohler. All rights reserved.
//

import Foundation
import os.log


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
        if !checkAppUpgraded() {
            os_log("Loading beers from local file.", log: OSLog.default, type: .debug)
            let beerList = (NSKeyedUnarchiver.unarchiveObject(withFile: Beer.ArchiveURL.path) as? [Beer])!
            return beerList
        }
        else {
            os_log("Not loading beers from local file. App got upgraded", log: OSLog.default, type: .debug)
        }
    }
    else {
        os_log("First time run.", log: OSLog.default, type: .debug)
    }
    
    return [Beer]()
}
