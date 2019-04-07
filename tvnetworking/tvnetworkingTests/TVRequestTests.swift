//
//  TVRequestTests.swift
//  tvnetworkingTests
//
//  Created by Tri Vo on 4/6/19.
//  Copyright © 2019 Tri Vo. All rights reserved.
//

import XCTest

@testable import tvnetworking



class TVRequestTests: XCTestCase {

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
    
    func testInitRequestWithGet() {
        let req = tvnetworking.TVRequest.init(method: .get, url: "https://www.google.com")
        XCTAssertEqual(req.method.rawValue, tvnetworking.TVHTTPMethod.get.rawValue)
        XCTAssertEqual(req.url, "https://www.google.com")
    }
    
    func testInitRequestWithHeaders() {
        let req = tvnetworking.TVRequest.init(method: .get, url: "https://www.google.com")
        req.headers = [TVHTTPHeader.init(field: "field", value: "my value")]
        req.headers?.append(TVHTTPHeader.init(field: "key", value: "sample"))
        XCTAssertEqual(req.method.rawValue, tvnetworking.TVHTTPMethod.get.rawValue)
        XCTAssertEqual(req.url, "https://www.google.com")
        XCTAssertTrue(req.headers?.count == 2)
        XCTAssertEqual(req.headers?.first?.field, "field")
        XCTAssertEqual(req.headers?.first?.value, "my value")
        XCTAssertEqual(req.headers?[1].field, "key")
        XCTAssertEqual(req.headers?[1].value, "sample")
    }
    
    func testInitRequestWithPost() {
        let req = tvnetworking.TVRequest.init(method: .post, url: "https://www.google.com")
        XCTAssertEqual(req.method.rawValue, tvnetworking.TVHTTPMethod.post.rawValue)
        XCTAssertEqual(req.url, "https://www.google.com")
    }
    
    func testInitRequestWithPostWithBody() {
        do {
            let body : Data? = try? "sample".data(using: .utf8)
            XCTAssertNotNil(body)
            let req = try tvnetworking.TVRequest.init(method: .post, url: "https://www.google.com", data: body!)
            XCTAssertEqual(req.method.rawValue, tvnetworking.TVHTTPMethod.post.rawValue)
            XCTAssertEqual(req.url, "https://www.google.com")
            XCTAssertNotNil(req.body)
            XCTAssertEqual(req.body, body)
        } catch (let err) {
            print("err: \(err)")
        }
        
    }
    
    func testInitRequestWithPut() {
        let req = tvnetworking.TVRequest.init(method: .put, url: "https://www.google.com")
        XCTAssertEqual(req.method.rawValue, tvnetworking.TVHTTPMethod.put.rawValue)
        XCTAssertEqual(req.url, "https://www.google.com")
    }
    
    func testInitRequestWithPuttWithBody() {
        do {
            let body : Data? = try? "sample".data(using: .utf8)
            XCTAssertNotNil(body)
            let req = try tvnetworking.TVRequest.init(method: .put, url: "https://www.google.com", data: body!)
            XCTAssertEqual(req.method.rawValue, tvnetworking.TVHTTPMethod.put.rawValue)
            XCTAssertEqual(req.url, "https://www.google.com")
            XCTAssertNotNil(req.body)
            XCTAssertEqual(req.body, body)
        } catch (let err) {
            print("err: \(err)")
        }
        
    }
    
    func testInitRequestWithDelete() {
        let req = tvnetworking.TVRequest.init(method: .delete, url: "https://www.google.com")
        XCTAssertEqual(req.method.rawValue, tvnetworking.TVHTTPMethod.delete.rawValue)
        XCTAssertEqual(req.url, "https://www.google.com")
    }
    
    func testInitRequestWithDeleteWithBody() {
        do {
            let body : Data? = try? "sample".data(using: .utf8)
            XCTAssertNotNil(body)
            let req = try tvnetworking.TVRequest.init(method: .delete, url: "https://www.google.com", data: body!)
            XCTAssertEqual(req.method.rawValue, tvnetworking.TVHTTPMethod.delete.rawValue)
            XCTAssertEqual(req.url, "https://www.google.com")
            XCTAssertNotNil(req.body)
            XCTAssertEqual(req.body, body)
        } catch (let err) {
            print("err: \(err)")
        }
        
    }
}
