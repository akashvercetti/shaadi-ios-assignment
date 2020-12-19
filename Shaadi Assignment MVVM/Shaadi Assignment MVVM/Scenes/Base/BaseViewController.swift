//
//  BaseViewController.swift
//  Shaadi Assignment Clean Architecture
//
//  Created by Akash Malhotra on 15/12/20.
//  Copyright © 2020 Akash Malhotra. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showIndicator() {
        Loader.showLoader(in: self)
    }
    
    func hideIndicator() {
        Loader.hideLoader()
    }
    
    func showError() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let errorAlert = UIAlertController(title: nil, message: "Something went wrong", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(errorAlert, animated: true, completion: nil)
        }
    }
}
