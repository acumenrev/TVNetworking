//
//  TVResponse.swift
//  tvnetworking
//
//  Created by Tri Vo on 4/6/19.
//  Copyright © 2019 Tri Vo. All rights reserved.
//

import Foundation

/// API Response
class TVResponse<T> {
    let statusCode : Int
    let body : T
    
    init(statusCode : Int, data : T) {
        self.statusCode = statusCode
        self.body = data
    }
}

/// API Response with data type in body
extension TVResponse where T == Data? {
    
    func decode<T : Decodable>(to type : T.Type) throws -> TVResponse<T> {
        guard let data = body else {
            throw TVHTTPError.decodingFailure
        }
        
        let decodedJSON = try JSONDecoder().decode(T.self, from: data)
        return TVResponse<T>(statusCode: self.statusCode, data: decodedJSON)
    }
}
