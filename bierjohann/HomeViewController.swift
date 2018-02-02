//
//  HomeViewController.swift
//  bierjohann
//
//  Created by Kohler Manuel on 31.01.18.
//  Copyright © 2018 Manuel Kohler. All rights reserved.
//

import UIKit
import os.log

class HomeViewController: UIViewController {
    
    func doLoadBeers() {
        // Load any saved beers, otherwise load data from website only
        if let savedBeers = loadBeers() {
            beers = harvestBeers(savedBeers: savedBeers)
        }
        else {
            // Loading data for the first time
            os_log("Loading beers for the first time.", log:OSLog.default, type: .debug)
            beers = extractAndInitBeers(webaddress: Constants.BIERJOHANN_URL)
            saveBeers(beers: beers)
        }
        
        // getting data from ratebeer.com
        for beer in beers {
            let searchString = [beer.brand, beer.type].flatMap({$0}).joined(separator: " ")
            _ = queryGraphql(apolloClient: apollo, searchString: searchString, beer: beer)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doLoadBeers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
