//
//  HomeConfigurator.swift
//  Shaadi Assignment Clean Architecture
//
//  Created by Akash Malhotra on 15/12/20.
//  Copyright (c) 2020 Akash Malhotra. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue: segue)
    }
}



class HomeConfigurator {

    static let sharedInstance: HomeConfigurator = HomeConfigurator()

  // MARK: Configuration
    func configure(viewController: HomeViewController) {
        let router = HomeRouter()
        router.viewController = viewController
    
        let presenter = HomePresenter()
        presenter.output = viewController
        
        let interactor = HomeInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
