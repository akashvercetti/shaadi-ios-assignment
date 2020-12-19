//
//  ShaadiUITests.swift
//  Shaadi Assignment Clean ArchitectureUITests
//
//  Created by Akash Malhotra on 18/12/20.
//  Copyright © 2020 Akash Malhotra. All rights reserved.
//

import XCTest

class ShaadiUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    //UI TEST TO CHECK IF THE TABLE CONTAINS CELLS
    func testUserTableContainsData() throws {
        
        let userCells = app.tables.staticTexts
        XCTAssertTrue(userCells.count != 0)
    }
    
    //UI TEST TO DETAIL SCREEN ROUTING
    func testHomeToDetailScreenNavigation() throws {
        let userCell = app.tables.staticTexts.firstMatch
        XCTAssertTrue(userCell.exists)
        userCell.tap()
        
        let detailScreenNavBar = app.navigationBars.buttons["Users"]
        XCTAssertTrue(detailScreenNavBar.exists)
        detailScreenNavBar.tap()
    }
    
    //UI TEST TO CHECK IF THE DETAIL SCREEN UI ELEMENTS EXIST
    func testDetailScreenUIElementsExist() throws {
        let userCell = app.tables.staticTexts.firstMatch
        XCTAssertTrue(userCell.exists)
        userCell.tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let detailScreenNavBar = app.navigationBars["Shaadi_Assignment_Clean_Architecture.UserDetailView"]
        let favoriteButton = detailScreenNavBar.buttons["btnStar"]
        
        let nameLabel = elementsQuery.staticTexts["lblName"]
        let phoneLabel = elementsQuery.staticTexts["lblPhone"]
        let websiteLabel = elementsQuery.staticTexts["lblWebsite"]
        let addressLabel = elementsQuery.staticTexts["lblAddress"]
        let companyLabel = elementsQuery.staticTexts["lblCompany"]
        
        XCTAssertTrue(nameLabel.exists)
        XCTAssertTrue(phoneLabel.exists)
        XCTAssertTrue(websiteLabel.exists)
        XCTAssertTrue(addressLabel.exists)
        XCTAssertTrue(companyLabel.exists)
        XCTAssertTrue(favoriteButton.exists)
    }
    
    //UI TEST TO VERIFY THE FAVORITE USER FLOW ON BOTH HOME AND DETAIL SCREENS.
    /*TAP THE USER CELL.
     TAP THE FAVORITE BUTTON AT DETAIL SCREEN.
     VERIFY THAT THE FAVORITE LABEL CONTAINS "FAVORITED"
     TAP THE BACK BUTTON
     VERIFY THAT THE FAVORTIE LABEL CONTAINS "FAVORITED"
     */
    func testClickFavoriteUser() throws {
        
        let userCell = app.tables.cells.firstMatch
        XCTAssertTrue(userCell.exists)
        userCell.tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let detailScreenNavBar = app.navigationBars["Shaadi_Assignment_Clean_Architecture.UserDetailView"]
        let favoriteButton = detailScreenNavBar.buttons["btnStar"]
        XCTAssertTrue(favoriteButton.exists)
        
        favoriteButton.tap()
        let favoriteLabel = elementsQuery.staticTexts["lblFavorite"]
        XCTAssertTrue(favoriteLabel.exists)
        XCTAssertTrue(favoriteLabel.label.lowercased().contains("favorited"))
        
        let backButton = detailScreenNavBar.buttons["Users"]
        backButton.tap()
        let favoriteCellLabel = userCell.staticTexts["lblFavorite"]
        XCTAssertTrue(favoriteCellLabel.label.lowercased().contains("favorited"))
    }
    
    //UI TEST TO TAP THE FAVORITE USER BUTTON TWICE (UNFAVORITE)
    /*TAP THE USER CELL.
     TAP THE FAVORITE BUTTON AT DETAIL SCREEN.
     VERIFY THAT THE FAVORITE LABEL CONTAINS "FAVORITED"
     TAP THE FAVORITE BUTTON
     VERIFY THAT THE FAVORITE LABEL IS GONE
     TAP THE BACK BUTTON
     VERIFY THAT THE FAVORTIE LABEL IS EMPTY
     */
    func testClickFavoriteUserTwice() throws {
        
        let userCell = app.tables.cells.firstMatch
        XCTAssertTrue(userCell.exists)
        userCell.tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let detailScreenNavBar = app.navigationBars["Shaadi_Assignment_Clean_Architecture.UserDetailView"]
        let favoriteButton = detailScreenNavBar.buttons["btnStar"]
        XCTAssertTrue(favoriteButton.exists)
        
        favoriteButton.tap()
        let favoriteLabel = elementsQuery.staticTexts["lblFavorite"]
        XCTAssertTrue(favoriteLabel.exists)
        XCTAssertTrue(favoriteLabel.label.lowercased().contains("favorited"))
        
        favoriteButton.tap()
        XCTAssertTrue(!favoriteLabel.exists)
        
        let backButton = detailScreenNavBar.buttons["Users"]
        backButton.tap()
        let favoriteCellLabel = userCell.staticTexts["lblFavorite"]
        XCTAssertTrue(favoriteCellLabel.label.isEmpty)
    }
    
    //UI TEST TO VERIFY THE FAVORITE USER FLOW ON BOTH HOME AND DETAIL SCREENS.
    /*TAP THE USER CELL.
     TAP THE FAVORITE BUTTON AT DETAIL SCREEN.
     VERIFY THAT THE FAVORITE LABEL CONTAINS "FAVORITED"
     TAP THE BACK BUTTON
     VERIFY THAT THE FAVORTIE LABEL CONTAINS "FAVORITED"
     TAP ANOTHER USER CELL.
     TAP THE FAVORITE BUTTON AT DETAIL SCREEN.
     VERIFY THAT THE FAVORITE LABEL CONTAINS "FAVORITED"
     TAP THE BACK BUTTON
     VERIFY THAT THE FAVORTIE LABEL CONTAINS "FAVORITED"
     */
    func testFavoriteMultipleUsers() throws {
        
        let userCell = app.tables.cells.firstMatch
        XCTAssertTrue(userCell.exists)
        userCell.tap()
        
        var elementsQuery = app.scrollViews.otherElements
        var detailScreenNavBar = app.navigationBars["Shaadi_Assignment_Clean_Architecture.UserDetailView"]
        var favoriteButton = detailScreenNavBar.buttons["btnStar"]
        XCTAssertTrue(favoriteButton.exists)
        
        favoriteButton.tap()
        var favoriteLabel = elementsQuery.staticTexts["lblFavorite"]
        XCTAssertTrue(favoriteLabel.exists)
        XCTAssertTrue(favoriteLabel.label.lowercased().contains("favorited"))
        
        var backButton = detailScreenNavBar.buttons["Users"]
        backButton.tap()
        var favoriteCellLabel = userCell.staticTexts["lblFavorite"]
        XCTAssertTrue(favoriteCellLabel.label.lowercased().contains("favorited"))
        
        
        //CHECK IF THERE ARE MORE THAN ONE USERS
        guard app.tables.cells.count > 1,
            let lastUserCell = app.tables.cells.allElementsBoundByIndex.last else {
                return
        }
        XCTAssertTrue(lastUserCell.exists)
        lastUserCell.tap()
        
        elementsQuery = app.scrollViews.otherElements
        detailScreenNavBar = app.navigationBars["Shaadi_Assignment_Clean_Architecture.UserDetailView"]
        favoriteButton = detailScreenNavBar.buttons["btnStar"]
        XCTAssertTrue(favoriteButton.exists)
        
        favoriteButton.tap()
        favoriteLabel = elementsQuery.staticTexts["lblFavorite"]
        XCTAssertTrue(favoriteLabel.exists)
        XCTAssertTrue(favoriteLabel.label.lowercased().contains("favorited"))
        
        backButton = detailScreenNavBar.buttons["Users"]
        backButton.tap()
        favoriteCellLabel = lastUserCell.staticTexts["lblFavorite"]
        XCTAssertTrue(favoriteCellLabel.label.lowercased().contains("favorited"))
    }
}
