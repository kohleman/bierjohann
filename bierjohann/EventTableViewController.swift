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
    var eventFirst = Event()

    override func viewDidLoad() {
        
        events = loadEventsfromFile()
        if (events.count == 0) {
            eventFirst = Event()
            os_log("%@", log: OSLog.default, type: .debug, "startingId is not defined, first run ever")

        }
        else {
            eventFirst = events.first!
            os_log("%@", log: OSLog.default, type: .debug, "Latest id loaded from file \(String(describing: eventFirst.id))")
        }
        
        events += extractEvents(eventFirst: eventFirst)
        
        // Needs sorting to make sure a new event is at the top
        events = events.sorted(by: { $0.id > $1.id })
        saveEvents()
        super.viewDidLoad()

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
        
        // Fetches the appropriate event for the data source layout.
        let event = events[indexPath.row]
        
        cell.dateLabel.text = event.date
        cell.titleLabel.text = event.title
        return cell
    }
    
    
    private func saveEvents() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(events, toFile: Event.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Events successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save events...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadEventsfromFile() -> [Event] {
        
        let fileExists = FileManager().fileExists(atPath: Event.ArchiveURL.path)
        if fileExists {
                os_log("Loading beers from local file.", log: OSLog.default, type: .debug)
                let eventList = (NSKeyedUnarchiver.unarchiveObject(withFile: Event.ArchiveURL.path) as? [Event])!
                return eventList
        }
        else {
            os_log("First time run.", log: OSLog.default, type: .debug)
        }
        
        return [Event]()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
                
            case "ShowEventDetail":
                guard let EventDetailViewController = segue.destination as? EventDetailViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                guard let selectedEventCell = sender as? EventTableViewCell else {
                    fatalError("Unexpected sender: \(sender ?? "Unknown" as AnyObject)")
                }
                
                guard let indexPath = tableView.indexPath(for: selectedEventCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                
                let selectedEvent = events[indexPath.row]
                EventDetailViewController.event = selectedEvent
                EventDetailViewController.navigationItem.hidesBackButton = false
                
            default:
                fatalError("Unexpected Segue Identifier")
            }
        }
    
    }


}
