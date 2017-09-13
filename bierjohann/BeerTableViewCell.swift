//
//  BeerTableViewCell.swift
//  bierjohann
//
//  Created by Kohler Manuel on 18.06.17.
//  Copyright © 2017 Kohler  Manuel (ID SIS). All rights reserved.
//

import UIKit
import os.log

class BeerTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!    
    @IBOutlet weak var numberLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // os_log("setSelected", log: OSLog.default, type: .debug)
        // Configure the view for the selected state
    }
}
