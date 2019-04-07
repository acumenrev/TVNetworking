//
//  TVHTTPClientTests.swift
//  tvnetworkingTests
//
//  Created by Tri Vo on 4/6/19.
//  Copyright © 2019 Tri Vo. All rights reserved.
//

import XCTest
import Foundation
@testable import tvnetworking
class TVHTTPClientTests: XCTestCase {
    
    let timeoutInterval : TimeInterval = 10.0
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetRequest() {
        let expectObj = self.expectation(description: "test get request")
        
        
        let client = tvnetworking.TVHTTPClient.init()
        client.get(url: "https://jsonplaceholder.typicode.com/posts/1", headers: nil) { (result) in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertEqual(response.statusCode, 200)
                XCTAssertNotNil(response.body)
                expectObj.fulfill()
                break
            default:
                break
            }
        }
        
        self.waitForExpectations(timeout: timeoutInterval) { (err) in
            print("test get request: \(err)")
        }
    }
    
    func testPostRequest() {
        let expectObj = self.expectation(description: "testPostRequest")
        
        
        let client = tvnetworking.TVHTTPClient.init()
        
        client.post(url: "https://jsonplaceholder.typicode.com/posts", body: nil, headers: nil) { (result) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 201)
                expectObj.fulfill()
                break
            default:
                break
            }
        }
        
        self.waitForExpectations(timeout: timeoutInterval) { (err) in
            print("testPostRequest: \(err)")
        }
    }
    
    func testPostRequestWithBody() {
        let expectObj = self.expectation(description: "testPostRequest")
        
        let body = "Etiam mi lacus, cursus vitae felis et".data(using: .utf8)
        let client = tvnetworking.TVHTTPClient.init()
        let headers = [TVHTTPHeader.init(field: "Content-Type", value: "text/plain")]
        client.post(url: "https://postman-echo.com/post", body: body, headers: headers) { (result) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 200)
                if let data = response.body, let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                    XCTAssertNotNil(dict["data"])
                    XCTAssertEqual((dict["data"] as? String), "Etiam mi lacus, cursus vitae felis et")
                    expectObj.fulfill()
                }
            default:
                break
            }
        }
        
        self.waitForExpectations(timeout: timeoutInterval) { (err) in
            print("testPostRequest: \(err)")
        }
    }
    
    func testPutRequest() {
        let expectObj = self.expectation(description: "testPutRequest")
        
        
        let client = tvnetworking.TVHTTPClient.init()
        
        client.put(url: "https://jsonplaceholder.typicode.com/posts/1", body: nil, headers: nil) { (result) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 200)
                expectObj.fulfill()
                break
            default:
                break
            }
        }
        
        self.waitForExpectations(timeout: timeoutInterval) { (err) in
            print("testPutRequest: \(err)")
        }
    }
    
    func testPutRequestWithData() {
        let expectObj = self.expectation(description: "testPutRequestWithData")
        
        let body = "Etiam mi lacus, cursus vitae felis et".data(using: .utf8, allowLossyConversion: true)
        
        let client = tvnetworking.TVHTTPClient.init()
        let headers = [TVHTTPHeader.init(field: "Content-Type", value: "text/plain")]
        
        client.put(url: "https://postman-echo.com/put", body: body, headers: headers) { (result) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 200)
                if let data = response.body, let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                    XCTAssertNotNil(dict["data"])
                    XCTAssertEqual((dict["data"] as? String), "Etiam mi lacus, cursus vitae felis et")
                    expectObj.fulfill()
                }
            default:
                break
            }
        }
        
        self.waitForExpectations(timeout: timeoutInterval) { (err) in
            print("testPutRequestWithData: \(err)")
        }
    }
    
    func testGetUTF8Response() {
        let expectObj = self.expectation(description: "testGetUTF8Response")
        
        
        let client = tvnetworking.TVHTTPClient.init()
        client.get(url: "https://postman-echo.com/encoding/utf8", headers: nil) { (result) in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertEqual(response.statusCode, 200)
                XCTAssertNotNil(response.body)
                if let body = response.body, let _ = String.init(data: body, encoding: .utf8) {
                    expectObj.fulfill()
                }
                
                break
            default:
                break
            }
        }
        
        self.waitForExpectations(timeout: timeoutInterval) { (err) in
            print("testGetUTF8Response: \(err)")
        }
    }
    
    func testDeleteRequest() {
        let expectObj = self.expectation(description: "testDeleteRequest")
        
        let body = "Etiam mi lacus, cursus vitae felis et".data(using: .utf8, allowLossyConversion: true)
        let client = tvnetworking.TVHTTPClient.init()
        
        client.delete(url: "https://postman-echo.com/delete", body: body, headers: nil) { (result) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 200)
                if let data = response.body, let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                    XCTAssertNotNil(dict["data"])
                    XCTAssertEqual((dict["data"] as? String), "Etiam mi lacus, cursus vitae felis et")
                    expectObj.fulfill()
                }
                break
            default:
                break
            }
        }
        
        self.waitForExpectations(timeout: timeoutInterval) { (err) in
            print("testDeleteRequest: \(err)")
        }
    }
    
    func testNotFoundErrorRequest() {
        let expectObj = self.expectation(description: "testNotFoundErrorRequest")
        
        
        let client = tvnetworking.TVHTTPClient.init()
        
        client.post(url: "https://jsonplaceholder.typicode.com/posts/1", body: nil, headers: nil) { (result) in
            switch result {
            case .fail(let err):
                switch err {
                case .notFound:
                    expectObj.fulfill()
                default:
                    break
                }
            default:
                break
            }
        }
        
        self.waitForExpectations(timeout: timeoutInterval) { (err) in
            print("testNotFoundErrorRequest: \(err)")
        }
    }
    
    func testWithInvalidUrl() {
        let expectObj = self.expectation(description: "testWithInvalidUrl")
        
        let client = tvnetworking.TVHTTPClient.init()
        client.get(url: "sampleurl http", headers: nil) { (result) in
            switch result {
            case .fail(let err):
                switch err {
                case .invalidURL:
                    expectObj.fulfill()
                default:
                    break
                }
            default:
                break
            }
        }
        
        self.waitForExpectations(timeout: timeoutInterval) { (err) in
            print("testWithInvalidUrl\(err)")
        }
    }
    
    func testWithRequestFailed() {
        let expectObj = self.expectation(description: "testWithRequestFailed")
        
        let client = tvnetworking.TVHTTPClient.init()
        client.get(url: "sampleurl", headers: nil) { (result) in
            switch result {
            case .fail(let err):
                switch err {
                case .invalidURL:
                    expectObj.fulfill()
                default:
                    break
                }
            default:
                break
            }
        }
        
        self.waitForExpectations(timeout: timeoutInterval) { (err) in
            print("testWithRequestFailed\(err)")
        }
    }
    
    func testWithRequestHeaders() {
        let expectObj = self.expectation(description: "testWithRequestHeaders")
        
        let headers = [tvnetworking.TVHTTPHeader.init(field: "Content-Type", value: "text/html"),
                       tvnetworking.TVHTTPHeader.init(field: "test", value: "response_headers")]
        
        let client = tvnetworking.TVHTTPClient.init()
        client.get(url: "https://postman-echo.com/headers", headers: headers) { (result) in
            switch result {
            case .success(let response):
                if let data = response.body, let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                    XCTAssertNotNil(dict["headers"])
                    expectObj.fulfill()
                }
                
            default:
                break
            }
        }
        
        self.waitForExpectations(timeout: timeoutInterval) { (err) in
            print("testWithRequestHeaders\(err)")
        }
    }
    
    func testWithResponseHeaders() {
        let expectObj = self.expectation(description: "testWithResponseHeaders")

        
        let client = tvnetworking.TVHTTPClient.init()
        client.get(url: "https://postman-echo.com/response-headers?Content-Type=text/html&test=response_headers", headers: nil) { (result) in
            switch result {
            case .success(let response):
                if let data = response.body, let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                    XCTAssertEqual((dict["Content-Type"] as? String), "text/html")
                    XCTAssertEqual((dict["test"] as? String), "response_headers")
                    expectObj.fulfill()
                }
                
            default:
                break
            }
        }
        
        self.waitForExpectations(timeout: timeoutInterval) { (err) in
            print("testWithResponseHeaders\(err)")
        }
    }
    
    func testWithTimeoutRequest() {
        let expectObj = self.expectation(description: "testWithTimeoutRequest")
        
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 3.0
        configuration.allowsCellularAccess = true
        configuration.networkServiceType = .default
        
        
        let client = tvnetworking.TVHTTPClient.init(withConfiguration: configuration)
        client.get(url: "https://postman-echo.com/delay/4", headers: nil) { (result) in
            switch result {
            case .fail(let err):
                switch err {
                case .requestTimeOut:
                    expectObj.fulfill()
                default:
                    break
                }
            default:
                break
            }
        }
        
        self.waitForExpectations(timeout: timeoutInterval) { (err) in
            print("testWithTimeoutRequest \(err)")
        }
    }
    
    func testWithBadRequest() {
        let expectObj = self.expectation(description: "testWithBadRequest")
        
        let client = tvnetworking.TVHTTPClient.init()
        client.get(url: "https://postman-echo.com/status/800", headers: nil) { (result) in
            switch result {
            case .fail(let err):
                switch err {
                case .badRequest(_):
                    expectObj.fulfill()
                default:
                    break
                }
            default:
                break
            }
        }
        
        self.waitForExpectations(timeout: timeoutInterval) { (err) in
            print("testWithBadRequest \(err)")
        }
    }
    
    func testForbiddenError() {
        let expectObj = self.expectation(description: "testForbiddenError")
        
        let client = tvnetworking.TVHTTPClient.init()
        client.get(url: "https://postman-echo.com/status/403", headers: nil) { (result) in
            switch result {
            case .fail(let err):
                switch err {
                case .forbidden(_):
                    expectObj.fulfill()
                default:
                    break
                }
            default:
                break
            }
        }
        
        self.waitForExpectations(timeout: timeoutInterval) { (err) in
            print("testForbiddenError \(err)")
        }
    }
    
    func testUnauthorzedRequest() {
        let expectObj = self.expectation(description: "testUnauthorzedRequest")
        
        let client = tvnetworking.TVHTTPClient.init()
        client.get(url: "https://postman-echo.com/status/401", headers: nil) { (result) in
            switch result {
            case .fail(let err):
                switch err {
                case .unauthorized(_):
                    expectObj.fulfill()
                default:
                    break
                }
            default:
                break
            }
        }
        
        self.waitForExpectations(timeout: timeoutInterval) { (err) in
            print("testUnauthorzedRequest \(err)")
        }
    }
    
    func testServerErrorRequest() {
        let expectObj = self.expectation(description: "testServerErrorRequest")
        
        let client = tvnetworking.TVHTTPClient.init()
        client.get(url: "https://postman-echo.com/status/500", headers: nil) { (result) in
            switch result {
            case .fail(let err):
                switch err {
                case .serverError(_):
                    expectObj.fulfill()
                default:
                    break
                }
            default:
                break
            }
        }
        
        self.waitForExpectations(timeout: timeoutInterval) { (err) in
            print("testServerErrorRequest \(err)")
        }
    }
}
