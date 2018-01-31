//
//  NetworkReachability.swift
//  bierjohann
//
//  Created by Kohler Manuel on 18.01.18.
//  Copyright © 2018 Manuel Kohler. All rights reserved.
//

import Foundation
import SystemConfiguration


let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com")


