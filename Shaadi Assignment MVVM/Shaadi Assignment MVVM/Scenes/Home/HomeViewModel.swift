//
//  HomeViewModel.swift
//  Shaadi Assignment MVVM
//
//  Created by Akash Malhotra on 16/12/20.
//  Copyright © 2020 Akash Malhotra. All rights reserved.
//

import Foundation
import UIKit

class HomeViewModel {
    
    private let networkManager = NetworkManager()
    var users: [User] = []
    
    var displayedUsers: Box<[HomeViewModel.DisplayedUser]> = Box([])
    var networkError: Box<Error?> = Box(nil)
    
    // MARK: FETCH USERS API CALL
    func fetchUsers() {
        let fetchUsersRequest = NetworkManager().getBaseRequest(urlStr: Endpoints.fetchUsers.rawValue, methodType: .GET)
        
        networkManager.makeNetworkCalls(urlRequest: fetchUsersRequest, objectType: [User].self) { (users, error) in
            
            guard error == nil else {
                self.networkError.value = error
                return
            }

            self.users = users ?? []
            self.displayedUsers.value = self.performPresentationLogic(users: users ?? [])
        }
    }
    
    // MARK: PRESENTATION LOGIC
    func performPresentationLogic(users: [User]) -> [HomeViewModel.DisplayedUser] {
        
        var displayedUsers: [HomeViewModel.DisplayedUser] = []
        
        for user in users {
            let isFav = (user.isFavorite ?? false) ? "Favorited! 👍" : ""
            let displayedUser = HomeViewModel.DisplayedUser(DisplayedName: user.name ?? "N/A", DisplayedFavoriteText: isFav)
            displayedUsers.append(displayedUser)
        }
        
        return displayedUsers
    }
}

// MARK: MARK USER AS FAVORITE PROTOCOL
extension HomeViewModel: UserFavoriteProtocol {
    
    func userMarked(isFavorite: Bool, id: Int) {
        
        for index in 0..<users.count {
            if users[index].id == id {
                users[index].isFavorite = isFavorite
                break
            }
        }
        displayedUsers.value = performPresentationLogic(users: users)
        displayedUsers.update()
    }
}

// MARK: PRESENTATION LOGIC MODELS
extension HomeViewModel {
    
    struct DisplayedUser {
        var DisplayedName: String
        var DisplayedFavoriteText: String
    }
}
