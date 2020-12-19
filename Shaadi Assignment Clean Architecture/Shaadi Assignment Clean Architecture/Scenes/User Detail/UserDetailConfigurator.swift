//
//  UserDetailConfigurator.swift
//  Shaadi Assignment Clean Architecture
//
//  Created by Akash Malhotra on 15/12/20.
//  Copyright (c) 2020 Akash Malhotra. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension UserDetailViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue: segue)
    }
}



class UserDetailConfigurator {

    static let sharedInstance: UserDetailConfigurator = UserDetailConfigurator()

  // MARK: Configuration
    func configure(viewController: UserDetailViewController) {
        let router = UserDetailRouter()
        router.viewController = viewController
    
        let presenter = UserDetailPresenter()
        presenter.output = viewController
        
        let interactor = UserDetailInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
