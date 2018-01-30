//
//  InfoViewController.swift
//  bierjohann
//
//  Created by Kohler Manuel on 25.01.18.
//  Copyright © 2018 Manuel Kohler. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {


    @IBOutlet weak var bierJohannTextView: UITextView!
    @IBOutlet weak var rateBeerTextView: UITextView!
    @IBOutlet weak var apolloTextView: UITextView!
    @IBOutlet weak var obfuscatorTextView: UITextView!
    @IBOutlet weak var swiftSoupTextView: UITextView!
    @IBOutlet weak var iconmonstrTextView: UITextView!
    
    override func viewDidLoad() {
        
        bierJohannTextView.text =
        """
        Beers are provided by:
        
        https://www.bierjohann.ch/
        Zum Bierjohann
        Elsässerstrasse 17
        4056 Basel
        bier@bierjohann.ch
        +41 61 5544644 
        """
        //bierJohannTextView.sizeToFit()
        //bierJohannTextView.layoutIfNeeded()

        rateBeerTextView.text =
        """
        Ratings:
        
        https://www.ratebeer.com/
        RateBeer, LLC
        P.O. Box 475
        Fulton, CA 95439
        API License: https://www.ratebeer.com/api-agreement.html
        """
        
        
        apolloTextView.text =
        """
        Apollo GraphQL 
        apollographql/apollo-codegen is licensed under the MIT License: 
        Copyright (c) 2016-2018 Meteor Development Group, Inc.
        MIT License

        Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the "Software"), to deal
        in the Software without restriction, including without limitation the rights
        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:

        The above copyright notice and this permission notice shall be included in all
        copies or substantial portions of the Software.

        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
        SOFTWARE.
        """

        obfuscatorTextView.text =
        """
        Thanks for the Obfuscator.swift by
        Dejan Atanasov: https://theappspace.com/ 
        """
        
        swiftSoupTextView.text =
        """
        http://www.scinfu.com/SwiftSoup/
        
        MIT License
        
        Copyright (c) 2016 Nabil Chatbi
        
        Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the "Software"), to deal
        in the Software without restriction, including without limitation the rights
        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:
        
        The above copyright notice and this permission notice shall be included in all
        copies or substantial portions of the Software.
        
        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
        SOFTWARE.
        """
        
        iconmonstrTextView.text =
        """
        Icons provided by:
        https://iconmonstr.com/
        """
        
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
