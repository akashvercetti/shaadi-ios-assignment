//
//  UserDetailViewModel.swift
//  Shaadi Assignment MVVM
//
//  Created by Akash Malhotra on 17/12/20.
//  Copyright © 2020 Akash Malhotra. All rights reserved.
//

import Foundation


class UserDetailViewModel {
    private let networkManager = NetworkManager()

    var DisplayedName: Box = Box("")
    var DisplayedUserName: Box = Box("")
    var DisplayedAddress: Box = Box("")
    var DisplayedPhone: Box = Box("")
    var DisplayedWebsite: Box = Box("")
    var DisplayedCompany: Box = Box("")
    var DisplayedFavoriteText: Box = Box("")
    
    var user: User?
    
    init() {
        loadUserValues()
    }
    
    // MARK: PRESENTATION LOGIC
    func loadUserValues() {
        DisplayedName.value = user?.name ?? "N/A"
        DisplayedUserName.value = user?.username ?? "N/A"
        
        let userAddress = "\(user?.address?.suite ?? ""), \(user?.address?.street ?? ""), \(user?.address?.city ?? "") - \(user?.address?.zipcode ?? "")"
        DisplayedAddress.value = userAddress
        
        DisplayedPhone.value = user?.phone ?? "N/A"
        DisplayedWebsite.value = user?.website ?? "N/A"
        DisplayedCompany.value = user?.company?.name ?? "N/A"
        updateFavoriteText()
    }
    
    func updateFavoriteText() {
        let isFav = (user?.isFavorite ?? false) ? "Favorited! 👍" : ""
        DisplayedFavoriteText.value = isFav
    }
    
    func starUser(markFavorite: Bool) {
        user?.isFavorite = markFavorite
        updateFavoriteText()
    }
}

