//
//  Beer.swift
//  bierjohann
//
//  Created by Kohler Manuel on 18.06.17.
//  Copyright © 2017 Kohler  Manuel. All rights reserved.
//

import UIKit
import os.log

var bierjohann_brown = UIColor(red:0.46, green:0.09, blue:0.02, alpha:1.0)

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
        
        extractBeers(webaddress: myURLString)
        
        print("Got \(self.beers.count) beers.")
        
        addRefreshControl()
        setUpdatedLabel()
        
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
        
        cell.RatingLabel.text = NSLocalizedString("RatingLabel", comment: "Translation for the Rating Label")
        
        let beer = beers[indexPath.row]

        cell.numberLabel.text = String(beer.runningNumber)
        cell.brandLabel.text = beer.brand
        cell.nameLabel.text = beer.type
        cell.ratingValue.text = String(beer.ratingValue)
        cell.ratingCount.text = String(beer.ratingCount)
        
        return cell
    }
    
    // called on a selected row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let beer = beers[indexPath.row]

        if #available(iOS 10.0, *) {
            os_log("Searching ...", log:OSLog.default, type: .debug)
        } else {
            // Fallback on earlier versions
        }
        
        let encodedBrand = prepareStringForURLSearch(s: beer.brand)
        let encodedName = prepareStringForURLSearch(s: beer.type)
        
        guard let url = URL(string: googleSearchString + encodedBrand + "+" + encodedName) else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    
    func extractBeers(webaddress: String) {

        var aBrand: String = ""
        var aName: String = ""
        var counter: Int = 1
        
        let myHTMLString = getURLSite(webaddress: webaddress)
        
        myHTMLString.enumerateLines { line, _ in
            if line.contains("slider__element--title") {
                aBrand = extractString(s: line)
            }

            if line.contains("slider__element--text") {
                aName = extractString(s: line)

                guard let aBeer = Beer(runningNumber: counter, brand: aBrand, type: aName, ratingValue: 0.0, ratingCount: 0) else {
                    fatalError("Unable to instantiate class Beer with " + aBrand)
                }
                self.beers.append(aBeer)
                counter += 1
            }
        }
    }
}


//https://www.ratebeer.com
//<div class="ratingValue" itemprop="ratingValue">55</div>
//<b><span id="_ratingCount8" itemprop="ratingCount" itemprop="reviewCount">41</span></b>

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


