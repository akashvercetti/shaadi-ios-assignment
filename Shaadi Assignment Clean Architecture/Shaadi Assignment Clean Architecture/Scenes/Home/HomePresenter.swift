//
//  HomePresenter.swift
//  Shaadi Assignment Clean Architecture
//
//  Created by Akash Malhotra on 15/12/20.
//  Copyright (c) 2020 Akash Malhotra. All rights reserved.
//

import UIKit

protocol HomePresenterInput {
  
    func presentLoader(type: HomeLoaderType)
    func hideLoader(type: HomeLoaderType)
    func presentError(type: HomeErrorType)
    func presentUsers(response: HomeModels.FetchUser.Response)
}

class HomePresenter: HomePresenterInput {
    
    var output: HomeViewControllerInput!
  
  // MARK: Presentation logic
  
    func presentLoader(type: HomeLoaderType) {
        
        output.displayLoader(type: type)
    }
    
    func hideLoader(type: HomeLoaderType) {
    
        output.hideLoader(type: type)
    }
    
    func presentError(type: HomeErrorType ) {
    
        output.displayError(type: type)
    }
    
    func presentUsers(response: HomeModels.FetchUser.Response) {
        
        let displayedUsers = performPresentationLogic(users: response.Users)
        
        let viewModel = HomeModels.FetchUser.ViewModel(DisplayedUsers: displayedUsers)
        output.displayUsers(viewModel: viewModel)
    }
    
    func performPresentationLogic(users: [User]) -> [HomeModels.FetchUser.ViewModel.DisplayedUser] {
        var displayedUsers: [HomeModels.FetchUser.ViewModel.DisplayedUser] = []
        
        for user in users {
            let isFav = (user.isFavorite ?? false) ? "Favorited! 👍" : ""
            let displayedUser = HomeModels.FetchUser.ViewModel.DisplayedUser(DisplayedName: user.name ?? "N/A", DisplayedFavoriteText: isFav)
            displayedUsers.append(displayedUser)
        }
        
        return displayedUsers
    }
}
