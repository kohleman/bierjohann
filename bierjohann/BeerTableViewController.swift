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
    
    let BierJohannName = "Bierjohann"
    let cellIdentifier = "BeerTableViewCell"
    
    @IBOutlet weak var HeaderUINavigationItem: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var Footer: UILabel!
    @IBOutlet weak var RefreshButton: UIBarButtonItem!
    @IBOutlet weak var MenuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        
        setUpdatedLabel()
//        addRefreshControl()
        
        super.viewDidLoad()

//        RefreshButton.action = #selector(BeerTableViewController.beerRefresh(sender:))
//        RefreshButton.tintColor = Constants.BIERJOHANN_BROWN
//        RefreshButton.target = self
        
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

        cell.ratingLabel.isHidden = true
        cell.ratingValue.isHidden = true
        cell.ratingCount.isHidden = true
        cell.countryCodeLabel.isHidden = true
        
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
                beerDetailViewController.navigationItem.hidesBackButton = false

//                let searchString = [selectedBeer.brand, selectedBeer.type].flatMap({$0}).joined(separator: " ")
//                _ = queryGraphql(apolloClient: apollo, searchString: searchString, beer: selectedBeer)


            default:
                fatalError("Unexpected Segue Identifier")
        }
    }



}


