//
//  UserDetailViewModelTest.swift
//  Shaadi Assignment Clean ArchitectureTests
//
//  Created by Akash Malhotra on 18/12/20.
//  Copyright © 2020 Akash Malhotra. All rights reserved.
//

import XCTest
@testable import Shaadi_Assignment_MVVM

class UserDetailViewModelTest: XCTestCase {
    
    var viewModel: UserDetailViewModel!
    var user = User(id: 1, name: "a", username: "a", email: "a", address: Address(street: "a", suite: "a", city: "a", zipcode: "a", geo: Geo(lat: "a", lng: "a")), phone: "a", website: "a", company: Company(name: "a", catchPhrase: "a", bs: "a"), isFavorite: true)
    
    override func setUp() {
        super.setUp()
        viewModel = UserDetailViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    //ISOLATE AND TEST USER DETAIL PRESENTATION LOGIC.
    func testUserDetailPresentationData() throws {
        viewModel.user = user
        viewModel.loadUserValues()
        
        XCTAssertEqual(viewModel.DisplayedName.value, user.name!)
        XCTAssertEqual(viewModel.DisplayedPhone.value, user.phone!)
        XCTAssertEqual(viewModel.DisplayedUserName.value, user.username!)
        XCTAssertEqual(viewModel.DisplayedWebsite.value, user.website!)
        XCTAssertEqual(viewModel.DisplayedCompany.value, user.company?.name!)
        XCTAssertEqual(viewModel.DisplayedFavoriteText.value.lowercased().contains("favorited"), user.isFavorite!)
        
        
    }
    
}
