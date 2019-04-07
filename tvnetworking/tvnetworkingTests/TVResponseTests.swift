//
//  TVResponseTests.swift
//  tvnetworkingTests
//
//  Created by Tri Vo on 4/6/19.
//  Copyright © 2019 Tri Vo. All rights reserved.
//

import XCTest
@testable import tvnetworking

class TVResponseTests: XCTestCase {

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
    
    func testInitResponse() {
        let body : Data? = try "sample".data(using: .utf8)
        
        let res = tvnetworking.TVResponse.init(statusCode: 200, data: body)
        XCTAssertEqual(res.statusCode, 200)
        XCTAssertNotNil(res.body)
        XCTAssertEqual(res.body, body)
    }
    
    func testDecodeWithEmptyData() {
        var data : Data? = nil
        let res = tvnetworking.TVResponse.init(statusCode: 200, data: data)
        XCTAssertEqual(res.statusCode, 200)
        XCTAssertNil(res.body)
    }
    
    
    
    func testDecodeResponse() {
        let jsonData  : Data? = "{\"userId\":1,\"id\":1,\"title\":\"sunt aut facere repellat provident occaecati excepturi optio reprehenderit\",\"body\":\"quia et suscipit\\nsuscipit recusandae consequuntur expedita et cum\\nreprehenderit molestiae ut ut quas totam\\nnostrum rerum est autem sunt rem eveniet architecto\"}".data(using: .utf8)
        let res = tvnetworking.TVResponse.init(statusCode: 200, data: jsonData)
        XCTAssertEqual(res.statusCode, 200)
        XCTAssertNotNil(res.body)
        XCTAssertEqual(res.body, jsonData)
        
        let decodedObj = try? res.decode(to: tvnetworking.TVSampleModel.self)
        XCTAssertNotNil(decodedObj)
        XCTAssertEqual(decodedObj?.statusCode, 200)
        XCTAssertNotNil(decodedObj?.body)
        
        let user = decodedObj?.body
        XCTAssertEqual(user?.userId, 1)
        XCTAssertEqual(user?.id, 1)
        XCTAssertEqual(user?.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        XCTAssertEqual(user?.body, "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
    }
}
