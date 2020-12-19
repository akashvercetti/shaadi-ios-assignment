//
//  UserFavoriteProtocol.swift
//  Shaadi Assignment Clean Architecture
//
//  Created by Akash Malhotra on 16/12/20.
//  Copyright © 2020 Akash Malhotra. All rights reserved.
//

import Foundation

protocol UserFavoriteProtocol {
    
    func userMarked(isFavorite: Bool, id: Int)
}
