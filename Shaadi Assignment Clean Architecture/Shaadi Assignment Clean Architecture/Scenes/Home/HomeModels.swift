//
//  HomeModels.swift
//  Shaadi Assignment Clean Architecture
//
//  Created by Akash Malhotra on 15/12/20.
//  Copyright (c) 2020 Akash Malhotra. All rights reserved.
//


import UIKit


enum HomeLoaderType {
  
    case general
}

enum HomeErrorType {
    
    case backend
}

struct HomeModels {


    struct FetchUser {
        
        struct Request {
            
        }
        
        struct Response {
            var Users: [User]
        }
        
        struct ViewModel {
            
            struct DisplayedUser {
                var DisplayedName: String
                var DisplayedFavoriteText: String
            }
            
            var DisplayedUsers: [DisplayedUser]
        }
    }
    
    struct StarUser {
        
        struct Request {
            var Id: Int
            var IsFavorite: Bool
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
        }
    }

}
