//
//  UserDetailRouter.swift
//  Shaadi Assignment Clean Architecture
//
//  Created by Akash Malhotra on 15/12/20.
//  Copyright (c) 2020 Akash Malhotra. All rights reserved.
//

import UIKit

protocol UserDetailRouterInput {

     func passDataToNextScene(segue: UIStoryboardSegue)
}

class UserDetailRouter: UserDetailRouterInput {
    weak var viewController: UserDetailViewController!
  
    // MARK: Navigation
    
    // MARK: Communication
  
    func passDataToNextScene(segue: UIStoryboardSegue) {
        // NOTE: Teach the router which scenes it can communicate with
    }

}
