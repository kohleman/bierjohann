//
//  EventTableViewController.swift
//  bierjohann
//
//  Created by Kohler Manuel on 16.12.17.
//  Copyright © 2017 Manuel Kohler. All rights reserved.
//

import Foundation
import UIKit
import os.log

class EventTableViewController: UITableViewController {
    
    var events = [Event]()
    
    private func loadEvents() {
        
        events = extractEvents()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadEvents()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "EventTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventTableViewCell  else {
            fatalError("The dequeued cell is not an instance of EventTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let event = events[indexPath.row]
        
        cell.dateLabel.text = event.date
        cell.titleLabel.text = event.title
        return cell
    }

}
