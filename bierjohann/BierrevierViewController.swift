//
//  BierrevierViewController.swift
//  bierjohann
//
//  Created by Kohler Manuel on 25.01.18.
//  Copyright © 2018 Manuel Kohler. All rights reserved.
//

import UIKit

class BierrevierViewController: UIViewController {

    @IBOutlet weak var googleMapsButton: UIButton!
    @IBOutlet weak var facebookImage: UIImageView!
    @IBOutlet weak var googleMapsImage: UIImageView!
    
    override func viewDidLoad() {
 
//        googleMapsButton.addTarget(self, action:  #selector(pressButton(_:)), for: .touchUpInside)
//        self.view.addSubview(googleMapsButton)
//
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        facebookImage.isUserInteractionEnabled = true
        facebookImage.addGestureRecognizer(tapGestureRecognizer)

        let googleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(googleImageTapped(tapGestureRecognizer:)))
        googleMapsImage.isUserInteractionEnabled = true
        googleMapsImage.addGestureRecognizer(googleTapGestureRecognizer)
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func googleImageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let mapsLink = "https://www.google.com/maps/place/Markthalle+Basel/@47.5492704,7.5848526,17z"
        
        guard let url = URL(string: mapsLink)
            else {
                return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }

    
    
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let mapsLink = "https://www.facebook.com/bierrevier/"
        
        guard let url = URL(string: mapsLink)
            else {
                return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    
    
    
//    @objc func pressButton(_ button: UIButton) {
//        print("Button with tag: \(button.tag) clicked!")
//
//        let mapsLink = "https://www.google.com/maps/place/Markthalle+Basel/@47.5492704,7.5848526,17z"
//
//        guard let url = URL(string: mapsLink)
//            else {
//                return //be safe
//        }
//
//        if #available(iOS 10.0, *) {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        } else {
//            UIApplication.shared.openURL(url)
//        }
//
//    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
