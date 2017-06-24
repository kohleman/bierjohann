//
//  BeerTableViewCell.swift
//  bierjohann
//
//  Created by Kohler Manuel on 18.06.17.
//  Copyright © 2017 Kohler  Manuel (ID SIS). All rights reserved.
//

import UIKit

class BeerTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func extractString(s: String) -> String {
        return s.components(separatedBy: ">")[1].components(separatedBy: "<")[0]
    }
    
    
    func getData() -> ([String], [String]){
        
        var brands: [String] = []
        var names: [String] = []
        
        let myURLString = "https://www.bierjohann.ch/"
        var brand: String = ""
        var name: String = ""
        
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return ([""], [""])
        }
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .utf8)
            myHTMLString.enumerateLines { line, _ in
                if line.contains("slider__element--title") {
                    brand = self.extractString(s: line)
                    brands.append(brand)
                }
                if line.contains("slider__element--text") {
                    name = self.extractString(s: line)
                    names.append(name)
                }
            }
        } catch let error {
            print("Error: \(error)")
        }
        
        return (brands, names)
    }
    
    

    
    func fillData() {
        var brands: [String] = []
        var names: [String] = []
        
        (brands, names) = getData()
        print(brands)
        print(names)
        
    }
    
}
