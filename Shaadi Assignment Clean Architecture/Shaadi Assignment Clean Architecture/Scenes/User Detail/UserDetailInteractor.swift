//
//  UserDetailInteractor.swift
//  Shaadi Assignment Clean Architecture
//
//  Created by Akash Malhotra on 15/12/20.
//  Copyright (c) 2020 Akash Malhotra. All rights reserved.
//

import UIKit

protocol UserDetailInteractorInput {
    
    var user: User! {get set}
    var starDelegate: UserFavoriteProtocol? {get set}
    
    func fetchUserDetail(request: UserDetailModels.FetchDetails.Request)
    func starUser(request: UserDetailModels.StarUser.Request)
}


class UserDetailInteractor: UserDetailInteractorInput {
  
    var output: UserDetailPresenterInput!
    var user: User!
    var starDelegate: UserFavoriteProtocol?
    
    func fetchUserDetail(request: UserDetailModels.FetchDetails.Request) {
        
        output.presentUserDetail(response: UserDetailModels.FetchDetails.Response(User: user))
    }
    
    func starUser(request: UserDetailModels.StarUser.Request) {
        user.isFavorite = request.MarkFavorite
        output.presentUserDetail(response: UserDetailModels.FetchDetails.Response(User: user))
    }
}
