//
//  BeerTableViewController.swift
//  bierjohann
//
//  Created by Kohler Manuel on 18.06.17.
//  Copyright © 2017 Kohler  Manuel. All rights reserved.
//

import UIKit
import os.log
import Apollo



class BeerTableViewController: UITableViewController {
    
    //MARK: Properties
    var beers = [Beer]()
    
    let BierJohannName = "Bierjohann"
    let cellIdentifier = "BeerTableViewCell"
    
    @IBOutlet weak var HeaderUINavigationItem: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var Footer: UILabel!
    @IBOutlet weak var RefreshButton: UIBarButtonItem!
    @IBOutlet weak var MenuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load any saved beers, otherwise load data from website only
        if let savedBeers = loadBeers() {
            beers = harvestBeers(savedBeers: savedBeers)
            
            for b in savedBeers {
                print(b.brand)
                print(b.timestamp)
                print("CC \(countryCodeToEmoji(country: (b.countryCode)))")
                
            }

        }
        else {
            // Loading data for the first time
            os_log("Loading beers for the first time.", log:OSLog.default, type: .debug)
            beers = extractAndInitBeers(webaddress: Constants.BIERJOHANN_URL)
            saveBeers(beers: beers)
        }
        
        setUpdatedLabel()
        addRefreshControl()
        
        
        RefreshButton.action = #selector(BeerTableViewController.beerRefresh(sender:))
        RefreshButton.tintColor = Constants.BIERJOHANN_BROWN
        RefreshButton.target = self
        
        
//        let emptyBeer = Beer(runningNumber: 1, brand: "Braukollektiv", type: "Horst", ratingValue: 0.0, ratingCount: 0, new: true, timestamp: 0, abv: 0.0, style: "", overallScore: 0.0)
//        enrichBeersWithRatings(beer: emptyBeer!)
//        print("CC \(countryCodeToEmoji(country: (emptyBeer?.countryCode)!))")
//        print("Brand \(emptyBeer?.brand ?? "b")")
//        print("ratingCount \(emptyBeer?.ratingCount ?? 11)")
//        print("overall Score \(emptyBeer?.overallScore ?? 0.1)")

    }
    
    
    func addRefreshControl () {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(beerRefresh(sender:)), for: UIControlEvents.valueChanged)
        self.refreshControl!.tintColor = UIColor(red:0.94, green:0.88, blue:0.77, alpha:1.0)
        self.refreshControl!.backgroundColor = Constants.BIERJOHANN_BROWN
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor(red:0.94, green:0.88, blue:0.77, alpha:1.0), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)]
        let fetching = NSLocalizedString("Fetching", comment: "Shows up on refreshing via pull")
        self.refreshControl!.attributedTitle = NSAttributedString(string: fetching, attributes: attributes)
        self.tableView.addSubview(refreshControl!)
    }
    
    func setUpdatedLabel() {
        let updated = NSLocalizedString("Updated", comment: "Label preceding the datetimestamp value")
        Footer.text = "\(updated): \(getTimestamp())"
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
            os_log("Oops... No data.", log:OSLog.default, type: .debug)
            HeaderUINavigationItem.title = NSLocalizedString("NoDataTitle", comment: "Data loading failed")
            return 0
        }
    }
    
    @objc func beerRefresh(sender:AnyObject)
    {
        let savedBeers = loadBeers()
        beers = harvestBeers(savedBeers: savedBeers!)
        setUpdatedLabel()
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

        let searchString = [beer.brand, beer.type].flatMap({$0}).joined(separator: " ")
        let res = queryGraphql(apolloClient: apollo, searchString: searchString, beer: beer)
        
//        if (beer.ratingCount < 0) {
            cell.ratingLabel.isHidden = true
            cell.ratingValue.isHidden = true
            cell.ratingCount.isHidden = true
            cell.countryCodeLabel.isHidden = true
//        }
//        else {
//            cell.ratingLabel.isHidden = false
//            cell.ratingValue.isHidden = false
//            cell.ratingCount.isHidden = false
//            cell.countryCodeLabel.isHidden = false
//        }
        
        cell.ratingValue.text = String(beer.overallScore)
        cell.ratingCount.text = String(beer.ratingCount)
        cell.countryCodeLabel.text = countryCodeToEmoji(country: beer.countryCode)

        cell.newLabel.isHidden = beer.new
        
        cell.nameLabel.adjustsFontSizeToFitWidth = true
        cell.nameLabel.minimumScaleFactor = 0.5
        cell.ratingCount.adjustsFontSizeToFitWidth = true
        cell.ratingCount.minimumScaleFactor = 0.5
        cell.ratingLabel.adjustsFontSizeToFitWidth = true
        cell.ratingLabel.minimumScaleFactor = 0.5
        
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        
            case "ShowBeerDetail":
                guard let beerDetailViewController = segue.destination as? BeerViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                guard let selectedBeerCell = sender as? BeerTableViewCell else {
                    fatalError("Unexpected sender: \(sender ?? "Unknown" as AnyObject)")
                }
                
                guard let indexPath = tableView.indexPath(for: selectedBeerCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                
                let selectedBeer = beers[indexPath.row]
                beerDetailViewController.beer = selectedBeer
                print("Selected \(selectedBeer.brand)")
                        
            default:
                fatalError("Unexpected Segue Identifier")
        }
    }



}


