//
//  DataModelTest.swift
//  Shaadi Assignment Clean ArchitectureTests
//
//  Created by Akash Malhotra on 16/12/20.
//  Copyright © 2020 Akash Malhotra. All rights reserved.
//

import XCTest
@testable import Shaadi_Assignment_Clean_Architecture

class DataModelTest: XCTestCase {
    
    var session: URLSessionMock!
    var manager: NetworkManager!
    
    override func setUp() {
        super.setUp()
        session = URLSessionMock()
        manager = NetworkManager(session: session)
    }
    
    override func tearDown() {
        session = nil
        manager = nil
        super.tearDown()
    }
    
    //MOCK THE RESPONSE OF THE API TO ISOLATE AND TEST THE NETWORK/DATA LAYER
    func testSuccessfulResponse() {
        
        let mockUser = [User(id: 1, name: "a", username: "a", email: "a", address: Address(street: "a", suite: "a", city: "a", zipcode: "a", geo: Geo(lat: "a", lng: "a")), phone: "a", website: "a", company: Company(name: "a", catchPhrase: "a", bs: "a"))]
        
        let encoder = JSONEncoder()
        let data = try? encoder.encode(mockUser)
        session.data = data
        
        let expectation = self.expectation(description: "Mock API Call Expectation")
        let fetchUsersRequest = NetworkManager().getBaseRequest(urlStr: Endpoints.fetchUsers.rawValue, methodType: .GET)
        
        
        var results: [User]?
        manager.makeNetworkCalls(urlRequest: fetchUsersRequest, objectType: [User].self) { (users, error) in
            results = users
            
            XCTAssertNil(error)
            XCTAssertEqual(results, mockUser, "The mocked api result should match the mocked user")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    //MOCK API CALL WITH A FAILED RESPONSE
    func testFailedResponse() {
        
        session.data = nil
        
        let expectation = self.expectation(description: "Mock API Call Expectation")
        let fetchUsersRequest = NetworkManager().getBaseRequest(urlStr: Endpoints.fetchUsers.rawValue, methodType: .GET)
        
        
        var results: [User]?
        manager.makeNetworkCalls(urlRequest: fetchUsersRequest, objectType: [User].self) { (users, error) in
            results = users
            
            XCTAssertNil(results, "The mocked api result should return nil data")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //TEST API CALL WITH AN INVALID URL
    func testMalformedURL() {
        
        session.data = nil
        
        let expectation = self.expectation(description: "Mock API Call Expectation")
        let fetchUsersRequest = NetworkManager().getBaseRequest(urlStr: "abc", methodType: .GET)
        
        
        var resultError: Error?
        manager.makeNetworkCalls(urlRequest: fetchUsersRequest, objectType: [User].self) { (users, error) in
            resultError = error
            
            XCTAssertNotNil(resultError)
            XCTAssertTrue(resultError is APIError)
            switch (resultError as! APIError) {
            case .apiError(let message):
                XCTAssertEqual(message, "Malformed URL")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
