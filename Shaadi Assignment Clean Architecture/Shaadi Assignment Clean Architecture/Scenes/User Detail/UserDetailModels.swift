//
//  UserDetailModels.swift
//  Shaadi Assignment Clean Architecture
//
//  Created by Akash Malhotra on 15/12/20.
//  Copyright (c) 2020 Akash Malhotra. All rights reserved.
//


import UIKit


enum UserDetailLoaderType {
  
    case general
}

enum UserDetailErrorType {
    
    case backend
}

struct UserDetailModels {


    struct FetchDetails {
        
        struct Request {
            
        }
        
        struct Response {
            var User: User
        }
        
        struct ViewModel {
            var DisplayedName: String
            var DisplayedAddress: String
            var DisplayedUserName: String
            var DisplayedPhone: String
            var DisplayedCompany: String
            var DisplayedWebsite: String
            var DisplayedFavoriteText: String
        }
    }
    
    struct StarUser {
        
        struct Request {
            var MarkFavorite: Bool
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
        }
    }

}
