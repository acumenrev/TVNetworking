//
//  TVRequest.swift
//  tvnetworking
//
//  Created by Tri Vo on 4/6/19.
//  Copyright © 2019 Tri Vo. All rights reserved.
//

import Foundation

/// HTTP Method
enum TVHTTPMethod : String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
}

/// HTTP Header
struct TVHTTPHeader {
    let field: String
    let value: String
}

/// API Request object
class TVRequest {
    let method : TVHTTPMethod
    let url : String
    var body : Data?
    var headers : [TVHTTPHeader]?
    
    
    /// Init request with http method and url
    init(method : TVHTTPMethod, url : String) {
        self.method = method
        self.url = url
    }
    
    /// init request with a body
    init<T: Encodable>(method : TVHTTPMethod, url : String, data : T) throws {
        self.method = method
        self.url = url
        if let jsonData = try? JSONEncoder().encode(data) {
            self.body = jsonData
        } else if let bodyData = data as? Data {
            self.body = bodyData
        }
    }
}
