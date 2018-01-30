//
//  EventDetailViewController.swift
//  bierjohann
//
//  Created by Kohler Manuel on 19.01.18.
//  Copyright © 2018 Manuel Kohler. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate{

    
    var event: Event?
    
    @IBOutlet weak var titleEventLabel: UILabel!
    @IBOutlet weak var dateEventLabel: UILabel!
    @IBOutlet weak var bodyEventTextView: UITextView!
    
    override func viewDidLoad() {
        
        titleEventLabel.text = event?.title
        dateEventLabel.text = event?.date
        bodyEventTextView.text = event?.body
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
