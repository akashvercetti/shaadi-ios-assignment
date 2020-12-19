//
//  HomeRouter.swift
//  Shaadi Assignment Clean Architecture
//
//  Created by Akash Malhotra on 15/12/20.
//  Copyright (c) 2020 Akash Malhotra. All rights reserved.
//

import UIKit

protocol HomeRouterInput {

    func passDataToNextScene(segue: UIStoryboardSegue)
    func navigateToUserDetails(user: User?)
}

class HomeRouter: HomeRouterInput {
    weak var viewController: HomeViewController!
  
    // MARK: Navigation
  
    func passDataToNextScene(segue: UIStoryboardSegue) {
        // NOTE: Teach the router which scenes it can communicate with
    }
    
    func navigateToUserDetails(user: User?) {
        guard let user = user else {
            return
        }
        let vc = UserDetailViewController.instantiateFromStoryboard()
        vc.output.user = user
        vc.output.starDelegate = viewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
