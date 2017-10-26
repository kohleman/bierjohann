
//  CreateApolloClient.swift
//  bierjohann
//
//  Created by Kohler Manuel on 11.10.17.
//  Copyright © 2017 Manuel Kohler. All rights reserved.
//

import Foundation
import Apollo
import os.log


func createApolloClient () -> ApolloClient {

    let o = Obfuscator(withSalt: [NSObject.self, NSString.self])
    let value = o.reveal(key: Constants.RATE_BEER_KEY)
    
    let apollo: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["x-api-key": value]
        
        let url = URL(string: Constants.RATE_BEER_API_ADDRESS)!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()

    return apollo
}


func queryGraphql(apolloClient: ApolloClient, searchString: String, beer: Beer) {
    
    _ = apolloClient.watch(query: BeerRatingQuery(q: searchString)) { (result, error) in
        guard let data = result?.data else {
            os_log("#### NO DATA found with %i %@!", log: OSLog.default, type: .debug, beer.runningNumber, searchString)
            return
        }
        
        os_log("Calles queryGraphql with %i %@", log: OSLog.default, type: .debug, beer.runningNumber, searchString)
        
        if (data.beerSearch?.items.isEmpty == false) {
            beer.desc = (data.beerSearch?.items[0]?.description) ?? ""
            beer.ratingValue = (data.beerSearch?.items[0]?.averageRating) ?? 0.0
            beer.ratingCount = (data.beerSearch?.items[0]?.ratingCount) ?? 0
            beer.countryCode = (data.beerSearch?.items[0]?.brewer?.country?.code) ?? ""
            beer.abv = (data.beerSearch?.items[0]?.abv) ?? 0.0
            beer.overallScore = (data.beerSearch?.items[0]?.overallScore) ?? 0.0
            beer.imageUrl = (data.beerSearch?.items[0]?.imageUrl) ?? ""
            
            beer.style.name = (data.beerSearch?.items[0]?.style.name) ?? ""
            beer.brewer.city = (data.beerSearch?.items[0]?.brewer?.city) ?? ""
            beer.brewer.web = (data.beerSearch?.items[0]?.brewer?.web) ?? ""
        }
    }
}
