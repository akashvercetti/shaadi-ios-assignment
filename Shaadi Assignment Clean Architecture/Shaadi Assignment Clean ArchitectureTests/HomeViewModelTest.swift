//
//  HomeViewModelTest.swift
//  Shaadi Assignment Clean ArchitectureTests
//
//  Created by Akash Malhotra on 18/12/20.
//  Copyright © 2020 Akash Malhotra. All rights reserved.
//

import XCTest
@testable import Shaadi_Assignment_Clean_Architecture

class HomeViewModelTest: XCTestCase {
    
    var homePresenter: HomePresenter!
    var users = [
        User(id: 1, name: "a", username: "a", email: "a", address: Address(street: "a", suite: "a", city: "a", zipcode: "a", geo: Geo(lat: "a", lng: "a")), phone: "a", website: "a", company: Company(name: "a", catchPhrase: "a", bs: "a"), isFavorite: true),
        User(id: 2, name: "a", username: "a", email: "a", address: Address(street: "a", suite: "a", city: "a", zipcode: "a", geo: Geo(lat: "a", lng: "a")), phone: "a", website: "a", company: Company(name: "a", catchPhrase: "a", bs: "a"), isFavorite: false)
    ]
    
    override func setUp() {
        super.setUp()
        
        homePresenter = HomePresenter()
    }
    
    override func tearDown() {
        homePresenter = nil
        super.tearDown()
    }
    
    //ISOLATE AND TEST THE PRESENTATION LOGIC TO BE DISPLAYED ON THE SCREEN. TEST IF THE THE FAVORITE LABEL TEXT MATCHES THE USER isFavorite VALUE, USING A MOCK USERS ARRAY
    func testUserListPresentationData() throws {
        let displayedUsers = homePresenter.performPresentationLogic(users: users)
        
        for (index, displayedUser) in displayedUsers.enumerated() {
            
            let user = users[index]
            
            XCTAssertEqual(displayedUser.DisplayedName, user.name!)
            XCTAssertEqual(displayedUser.DisplayedFavoriteText.lowercased().contains("favorited"), user.isFavorite!)
        }
    }
    
}
