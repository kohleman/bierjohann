//
//  BeerViewController.swift
//  bierjohann
//
//  Created by Kohler Manuel on 23.10.17.
//  Copyright © 2017 Manuel Kohler. All rights reserved.
//

import UIKit

class BeerViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var beerNewLabel: UILabel!
    @IBOutlet weak var beerNumberLabel: UILabel!
    @IBOutlet weak var beerFlagLabel: UILabel!
    @IBOutlet weak var beerBrandLabel: UILabel!
    @IBOutlet weak var beerTypelabel: UILabel!
//      @IBOutlet weak var beerRatingValue: UITextField!
    @IBOutlet weak var beerRatingCount: UILabel!
    @IBOutlet weak var beerAbv: UILabel!
    @IBOutlet weak var beerOverallScore: UILabel!
    @IBOutlet weak var beerStyleName: UILabel!
    @IBOutlet weak var beerBrewerCity: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var beerBrewerWebaddress: UILabel!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var overallScoreLabel: UILabel!
    @IBOutlet weak var StyleLabel: UILabel!
    @IBOutlet weak var ratingcountLabel: UILabel!
    @IBOutlet weak var brewerCity: UILabel!
    @IBOutlet weak var beerDescr: UILabel!
    @IBOutlet weak var webAddressLabel: UILabel!
    
    
    var beer: Beer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: self.view.frame.size.width-100, height: 1000)
        
        if let beer = beer {
            navigationItem.title = ""
            navigationItem.backBarButtonItem?.isEnabled = true

            beerNewLabel.isHidden = beer.new
            beerNumberLabel.text = String(beer.runningNumber)
            beerFlagLabel.text = countryCodeToEmoji(country: beer.countryCode)
            beerBrandLabel.text = beer.brand
            beerTypelabel.text = beer.type
//            beerRatingValue.text = String(roundOneDecimals(d: beer.ratingValue))
            beerRatingCount.text = String(beer.ratingCount)
            beerAbv.text = String(roundOneDecimals(d: beer.abv)) + " %"
            beerOverallScore.text = String(roundOneDecimals(d: beer.overallScore))
            beerStyleName.text = beer.style.name
            beerBrewerCity.text = beer.brewer.city
            beerDescription.text = beer.desc
            beerBrewerWebaddress.text = beer.web
            
            typeLabel.text = "Beer Name"
            brandLabel.text  = "Brewer"
            abvLabel.text = "ABV"
            overallScoreLabel.text = "Score from 100 max"
            StyleLabel.text = "Beer Style"
            ratingcountLabel.text = "# of Ratings"
            brewerCity.text = "Brewer's city"
            beerDescr.text = "Beer Description"
            
        }
        
        searchButton.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
    }
    
    @objc private func buttonClicked() {
        let encodedBrand = prepareStringForURLSearch(s: (beer?.brand)!)
        let encodedType = prepareStringForURLSearch(s: (beer?.type)!)

        guard let url = URL(string: Constants.GOOGLE_SEARCH_STRING + "\(encodedBrand  )+\(encodedType)")
            else {
                return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

