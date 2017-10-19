//
//  createApolloClient.swift
//  bierjohann
//
//  Created by Kohler Manuel on 11.10.17.
//  Copyright © 2017 Manuel Kohler. All rights reserved.
//

import Foundation
import Apollo



func createApolloClient () -> ApolloClient {

    let apollo: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["x-api-key": ""]
        
        let url = URL(string: "https://api.r8.beer/v1/api/graphql/")!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()

    return apollo
}
