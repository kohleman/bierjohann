//
//  BeerTableViewController.swift
//  bierjohann
//
//  Created by Kohler Manuel on 18.06.17.
//  Copyright © 2017 Kohler  Manuel. All rights reserved.
//

import UIKit
import os.log

var bierjohann_brown = UIColor(red:0.46, green:0.09, blue:0.02, alpha:1.0)
let dayInSeconds = 3600*24
//let dayInSeconds = 120


class BeerTableViewController: UITableViewController {
    
    //MARK: Properties
    var beers = [Beer]()
    
    let myURLString = "https://www.bierjohann.ch/"
    let BierJohannName = "Bierjohann"
    let cellIdentifier = "BeerTableViewCell"
    let googleSearchString = "https://www.google.com/search?q="
    
    @IBOutlet weak var HeaderUINavigationItem: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var Footer: UILabel!
    @IBOutlet weak var RefreshButton: UIBarButtonItem!
    @IBOutlet weak var MenuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load any saved beers, otherwise load sample data.
        if let savedBeers = loadBeers() {
        
            extractBeers(webaddress: myURLString)
            print("Got \(self.beers.count) beers.")

            let diffIndex = diffBeers(savedBeers: savedBeers)

        }
        else {
            // Loading data for the first time
            print("Loading beers for the first time.")
            extractBeers(webaddress: myURLString)
        }
        
        
        saveBeers()
        setUpdatedLabel()

        addRefreshControl()
        
        RefreshButton.action = #selector(BeerTableViewController.beerRefresh(sender:))
        RefreshButton.tintColor = bierjohann_brown
        RefreshButton.target = self
    }
    
    func addRefreshControl () {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(beerRefresh(sender:)), for: UIControlEvents.valueChanged)
        self.refreshControl!.tintColor = UIColor(red:0.94, green:0.88, blue:0.77, alpha:1.0)
        self.refreshControl!.backgroundColor = bierjohann_brown
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor(red:0.94, green:0.88, blue:0.77, alpha:1.0), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)]
        let fetching = NSLocalizedString("Fetching", comment: "Shows up on refreshing via pull")
        self.refreshControl!.attributedTitle = NSAttributedString(string: fetching, attributes: attributes)
        self.tableView.addSubview(refreshControl!)
    }
    
    func setUpdatedLabel() {
        let updated = NSLocalizedString("Updated", comment: "Label preceding the datetimestamp value")
        Footer.text = "\(updated): \(get_timestamp())"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        if (beers.count > 0) {
            HeaderUINavigationItem.title =  BierJohannName + " " + NSLocalizedString("Title", comment: "Title within the app")
            HeaderUINavigationItem.leftBarButtonItem?.title = "Info"
            return 1
        }
        else {
            print("No data...")
            HeaderUINavigationItem.title = NSLocalizedString("NoDataTitle", comment: "Data loading failed")
            return 0
        }
    }
    
    @objc func beerRefresh(sender:AnyObject)
    {
        extractBeers(webaddress: myURLString)
        let savedBeers = loadBeers()
        diffBeers(savedBeers: savedBeers!)
        setUpdatedLabel()
        saveBeers()
        tableView.reloadData()
        self.refreshControl!.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BeerTableViewCell  else {
            fatalError("The dequeued cell is not an instance of BeerTableViewCell.")
        }
        
        cell.ratingLabel.text = NSLocalizedString("RatingLabel", comment: "Translation for the Rating Label")
        
        let beer = beers[indexPath.row]

        cell.numberLabel.text = String(beer.runningNumber)
        cell.brandLabel.text = beer.brand
        cell.nameLabel.text = beer.type
        
        // Just hide it for now...
        if (beer.ratingCount == 0) {
            cell.ratingLabel.isHidden = true
            cell.ratingValue.isHidden = true
            cell.ratingCount.isHidden = true
        }
        
        cell.ratingValue.text = String(beer.ratingValue)
        cell.ratingCount.text = String(beer.ratingCount)
        
        cell.newLabel.isHidden = beer.new
        return cell
    }
    
    // called on a selected row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let beer = beers[indexPath.row]
        
        if #available(iOS 10.0, *) {
            os_log("Searching...", log:OSLog.default, type: .debug)
        } else {
            // Fallback on earlier versions
        }
        
        let encodedBrand = prepareStringForURLSearch(s: beer.brand)
        let encodedType = prepareStringForURLSearch(s: replaceAmpForSearch(s: beer.type))
        
        let cleanBrand = replaceAmpForSearch(s:encodedBrand)
        let cleanType = replaceAmpForSearch(s: encodedType)
        
        guard let url = URL(string: googleSearchString + "\(cleanBrand  )+\(cleanType)") else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

    //MARK: Private Methods
    private func extractBeers(webaddress: String) {

        var aBrand: String = ""
        var aName: String = ""
        var counter: Int = 1
        
        self.beers.removeAll()
        
        let myHTMLString = getURLSite(webaddress: webaddress)
        
        myHTMLString.enumerateLines { line, _ in
            if line.contains("slider__element--title") {
                aBrand = extractString(s: line)
            }

            if line.contains("slider__element--text") {
                aName = extractString(s: line)

                guard let aBeer = Beer(runningNumber: counter, brand: aBrand, type: aName, ratingValue: 0.0, ratingCount: 0, new: true, timestamp: 0) else {
                    fatalError("Unable to instantiate class Beer with " + aBrand)
                }
                self.beers.append(aBeer)
                counter += 1
            }
        }
    }
    
    public func diffBeers(savedBeers: [Beer]) -> [Int] {
        
//        beers[3].brand = "Beer4"
//        beers[3].type = "T4"
//        beers[3].timestamp = 1506438938 + 30000
        
        let now = Date().secondsSince1970
        
        let timeIndex = zip(beers, savedBeers).enumerated().filter() {
            (now - $1.1.timestamp) < dayInSeconds
            }.map{$0.0}

        print(timeIndex)
        print("Beer with new timestamp found \(timeIndex)")

        for index in timeIndex {
            beers[index].new = false
            // save the timestamp when this was found as a new beer
            beers[index].timestamp = savedBeers[index].timestamp
        }
        
            
        let diffIndex = zip(beers, savedBeers).enumerated().filter() {
            $1.0.brand != $1.1.brand && $1.0.type != $1.1.type
            }.map{$0.0}
        
        
        print("New beer found \(diffIndex)")
        
        for index in diffIndex {
            beers[index].new = false
            beers[index].timestamp = Date().secondsSince1970
        }

        return diffIndex
    }
        
        

    private func saveBeers() {
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
        return NSKeyedUnarchiver.unarchiveObject(withFile: Beer.ArchiveURL.path) as? [Beer]
    }

    
}
