//
//  BeerViewController.swift
//  bierjohann
//
//  Created by Kohler Manuel on 23.10.17.
//  Copyright © 2017 Manuel Kohler. All rights reserved.
//

import UIKit



class BeerViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var beerNumberLabel: UILabel!
    @IBOutlet weak var beerFlagLabel: UILabel!
    @IBOutlet weak var beerBrandLabel: UILabel!
    @IBOutlet weak var beerTypelabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    
    
    var beer: Beer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Set up views if editing an existing Meal.
        if let beer = beer {
            navigationItem.title = ""
            navigationItem.backBarButtonItem?.isEnabled = true

            beerNumberLabel.text = String(beer.runningNumber)
            beerFlagLabel.text = countryCodeToEmoji(country: beer.countryCode)
            beerBrandLabel.text = beer.brand
            beerTypelabel.text = beer.type
            
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

