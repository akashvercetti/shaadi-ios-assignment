//
//  UserDetailViewModelTest.swift
//  Shaadi Assignment Clean ArchitectureTests
//
//  Created by Akash Malhotra on 18/12/20.
//  Copyright © 2020 Akash Malhotra. All rights reserved.
//

import XCTest
@testable import Shaadi_Assignment_Clean_Architecture

class UserDetailViewModelTest: XCTestCase {
    
    var userDetailPresenter: UserDetailPresenter!
    let user = User(id: 1, name: "a", username: "a", email: "a", address: Address(street: "a", suite: "a", city: "a", zipcode: "a", geo: Geo(lat: "a", lng: "a")), phone: "a", website: "a", company: Company(name: "a", catchPhrase: "a", bs: "a"), isFavorite: true)
    
    override func setUp() {
        super.setUp()
        userDetailPresenter = UserDetailPresenter()
    }
    
    override func tearDown() {
        userDetailPresenter = nil
        super.tearDown()
    }
    
    //ISOLATE AND TEST USER DETAIL PRESENTATION LOGIC.
    func testUserDetailPresentationData() throws {
        let viewModel = userDetailPresenter.performPresentationLogic(user: user)
        
        XCTAssertEqual(viewModel.DisplayedName, user.name!)
        XCTAssertEqual(viewModel.DisplayedPhone, user.phone!)
        XCTAssertEqual(viewModel.DisplayedUserName, user.username!)
        XCTAssertEqual(viewModel.DisplayedWebsite, user.website!)
        XCTAssertEqual(viewModel.DisplayedCompany, user.company?.name!)
        XCTAssertEqual(viewModel.DisplayedFavoriteText.lowercased().contains("favorited"), user.isFavorite!)
    }
    
}
