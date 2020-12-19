//
//  HomeInteractor.swift
//  Shaadi Assignment Clean Architecture
//
//  Created by Akash Malhotra on 15/12/20.
//  Copyright (c) 2020 Akash Malhotra. All rights reserved.
//

import UIKit

protocol HomeInteractorInput {
    
    var users: [User] {get set}
    func fetchUsers(request: HomeModels.FetchUser.Request)
    func starUser(request: HomeModels.StarUser.Request)
}


class HomeInteractor: HomeInteractorInput {
  
    var output: HomePresenterInput!
    var users: [User] = []
    
    func fetchUsers(request: HomeModels.FetchUser.Request) {
        
        let fetchUsersRequest = NetworkManager().getBaseRequest(urlStr: Endpoints.fetchUsers.rawValue, methodType: .GET)

        output.presentLoader(type: .general)
        NetworkManager().makeNetworkCalls(urlRequest: fetchUsersRequest, objectType: [User].self) { (users, error) in
            
            self.output.hideLoader(type: .general)
            
            guard error == nil else {
                self.output.presentError(type: .backend)
                return
            }
            
            self.users = users ?? []
            self.output.presentUsers(response: HomeModels.FetchUser.Response(Users: self.users))
        }
    }
    
    func starUser(request: HomeModels.StarUser.Request) {
        
        for index in 0..<users.count {
            if users[index].id == request.Id {
                users[index].isFavorite = request.IsFavorite
                break
            }
        }
        output.presentUsers(response: HomeModels.FetchUser.Response(Users: users))
    }
}
