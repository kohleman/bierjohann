//
//  extra_function.swift
//  bierjohann
//
//  Created by Kohler Manuel on 01.07.17.
//  Copyright © 2017 Kohler  Manuel (ID SIS). All rights reserved.
//

import Foundation


func extractString_ZZ (s: String) -> String {
    return s.components(separatedBy: ">")[1].components(separatedBy: "<")[0]
}
