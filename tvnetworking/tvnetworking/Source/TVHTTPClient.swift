//
//  TVHTTPManager.swift
//  tvnetworking
//
//  Created by Tri Vo on 4/6/19.
//  Copyright © 2019 Tri Vo. All rights reserved.
//

import Foundation

class TVHTTPClient {
    
    fileprivate let httpSession : URLSession
    
    typealias APIClientCallback = (TVResult<Data?>) -> Void
    
    /// Use default URLSession.shared
    init() {
        httpSession = URLSession.shared
    }
    
    /// Init with configuration
    init(withConfiguration config : URLSessionConfiguration) {
        httpSession = URLSession.init(configuration: config)
    }
    
    
    /// Handle error from request
    ///
    /// - Parameters:
    ///   - httpResponse: HTTPResponse objecty
    ///   - data: Data from response
    ///   - callback: Callback
    fileprivate func handleError(_ code: Int, _ data: Data?, _ callback: APIClientCallback) {
        switch code {
        case 400:
            /// bad request
            callback(.fail(.badRequest(data)))
        case 401:
            /// Unauthorized
            callback(.fail(.unauthorized(data)))
        case 403:
            /// Forbidden
            callback(.fail(.forbidden(data)))
        case 404:
            /// Resource cannot be found
            callback(.fail(.notFound))
        case 500:
            /// Server error
            callback(.fail(.serverError(data)))
        case -1001:
            /// Request time out
            callback(.fail(.requestTimeOut))
        case -1002:
            /// Bad URL
            callback(.fail(.invalidURL))
        case -1004, -1005, -1006, -1008, -1018:
            /// Server is not reachable
            callback(.fail(.notReachable(code)))
        default:
            /// unknown error
            callback(.fail(.unknownError(code,data)))
        }
    }
    
    /// Perform HTTP Request
    fileprivate func perform(request : TVRequest, callback : @escaping APIClientCallback) ->  Void {
        /// init URL object
        /// unless it will return an invalid url error
        guard let url = URL.init(string: request.url) else {
            callback(.fail(.invalidURL))
            return
        }
        
        /// init URL Request
        var urlReq = URLRequest.init(url: url)
        urlReq.httpBody = request.body
        urlReq.httpMethod = request.method.rawValue
        
        /// assign headers
        if let _ = request.headers {
            request.headers?.forEach({ (header) in
                urlReq.addValue(header.value, forHTTPHeaderField: header.field)
            })
        } else {
            /// if there is no header
            /// assign default header content type json
            urlReq.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type ")
        }
        
        
        /// init URLSession task
        weak var weakSelf = self
        let task = httpSession.dataTask(with: urlReq) { (data, response, err) in
            if let nsErr = err as NSError? {
                weakSelf?.handleError(nsErr.code, data, callback)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                callback(.fail(.requestFailed))
                return
            }
            
            // validate
            let okRange = 200..<300
            if okRange.contains(httpResponse.statusCode) {
                callback(.success(TVResponse<Data?>(statusCode: httpResponse.statusCode, data: data)))
            } else {
                weakSelf?.handleError(httpResponse.statusCode, data, callback)
            }
        }
        
        /// send request
        task.resume()
    }
    

    
    /// Close All Requests
    func cancelAllRequests() {
        httpSession.invalidateAndCancel()
    }
}


// MARK: - GET
extension TVHTTPClient {
    
    /// GET method
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - headers: HTTP Headers
    ///   - callback: Callback
    func get(url : String, headers : [TVHTTPHeader]?, callback : @escaping APIClientCallback) {
        let req = TVRequest.init(method: .get, url: url)
        req.headers = headers
        self.perform(request: req, callback: callback)
    }
}


// MARK: - POST
extension TVHTTPClient {
    
    
    /// POST method
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - body: Request body
    ///   - headers: HTTP headers
    ///   - callback: Callback
    func post(url : String, body : Data?, headers : [TVHTTPHeader]?, callback : @escaping APIClientCallback) {
        var req : TVRequest?
        if let body = body {
            req = try? TVRequest.init(method: .post, url: url, data: body)
        } else {
            req = TVRequest.init(method: .post, url: url)
        }
        guard let request = req else {
            callback(.fail(.requestFailed))
            return
        }
        request.headers = headers
        self.perform(request: request, callback: callback)
    }
}


// MARK: - PUT
extension TVHTTPClient {
    
    /// PUT method
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - body: Request body
    ///   - headers: HTTP headers
    ///   - callback: Callback
    func put(url : String, body : Data?, headers : [TVHTTPHeader]?, callback : @escaping APIClientCallback) {
        var req : TVRequest?
        if let body = body {
            req = try? TVRequest.init(method: .put, url: url, data: body)
        } else {
            req = TVRequest.init(method: .put, url: url)
        }
        guard let request = req else {
            callback(.fail(.requestFailed))
            return
        }
        request.headers = headers
        self.perform(request: request, callback: callback)
    }
}

// MARK: - DELETE
extension TVHTTPClient {
    
    /// DELETE method
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - body: Request body
    ///   - headers:  Headers
    ///   - callback: Callback
    func delete(url : String, body : Data?, headers : [TVHTTPHeader]?, callback : @escaping APIClientCallback) {
        var req : TVRequest?
        if let body = body {
            req = try? TVRequest.init(method: .delete, url: url, data: body)
        } else {
            req = TVRequest.init(method: .delete, url: url)
        }
        guard let request = req else {
            callback(.fail(.requestFailed))
            return
        }
        request.headers = headers
        self.perform(request: request, callback: callback)
    }
}


