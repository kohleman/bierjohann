//
//  Extensions.swift
//  bierjohann
//
//  Created by Kohler Manuel on 05.10.17.
//  Copyright © 2017 Manuel Kohler. All rights reserved.
//

import Foundation

public extension Date {
    // Usage print(Date().secondsSince1970)
    var secondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970).rounded())
    }
    
    init(seconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(seconds))
    }
}

public extension String {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
