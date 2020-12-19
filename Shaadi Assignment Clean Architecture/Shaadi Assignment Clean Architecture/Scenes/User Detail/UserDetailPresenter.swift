//
//  UserDetailPresenter.swift
//  Shaadi Assignment Clean Architecture
//
//  Created by Akash Malhotra on 15/12/20.
//  Copyright (c) 2020 Akash Malhotra. All rights reserved.
//

import UIKit

protocol UserDetailPresenterInput {
  
    func presentLoader(type: UserDetailLoaderType)
    func hideLoader(type: UserDetailLoaderType)
    func presentError(type: UserDetailErrorType)
    func presentUserDetail(response: UserDetailModels.FetchDetails.Response)
}

class UserDetailPresenter: UserDetailPresenterInput {
    
    var output: UserDetailViewControllerInput!
  
  // MARK: Presentation logic
  
    func presentLoader(type: UserDetailLoaderType) {
        
        output.displayLoader(type: type)
    }
    
    func hideLoader(type: UserDetailLoaderType) {
    
        output.hideLoader(type: type)
    }
    
    func presentError(type: UserDetailErrorType ) {
    
        output.displayError(type: type)
    }
    
    func presentUserDetail(response: UserDetailModels.FetchDetails.Response) {
        
        let viewModel = performPresentationLogic(user: response.User)
        output.displayUserDetail(viewModel: viewModel)
    }
    
    func performPresentationLogic(user: User) -> UserDetailModels.FetchDetails.ViewModel {
        
        let address = getDisplayedAddress(user: user)
        let isFav = getDisplayedFavoritedText(user: user)
            
        
        let viewModel = UserDetailModels.FetchDetails.ViewModel(DisplayedName: user.name ?? "N/A", DisplayedAddress: address, DisplayedUserName: user.username ?? "N/A", DisplayedPhone: user.phone ?? "N/A", DisplayedCompany: user.company?.name ?? "N/A", DisplayedWebsite: user.website ?? "N/A", DisplayedFavoriteText: isFav)
        
        return viewModel
    }
    
    func getDisplayedAddress(user: User) -> String {
        return "\(user.address?.suite ?? ""), \(user.address?.street ?? ""), \(user.address?.city ?? "") - \(user.address?.zipcode ?? "")"
    }
    
    func getDisplayedFavoritedText(user: User) -> String {
        return (user.isFavorite ?? false) ? "Favorited! 👍" : ""
    }
}
