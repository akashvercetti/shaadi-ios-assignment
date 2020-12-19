//
//  Loader.swift
//  Shaadi Assignment Clean Architecture
//
//  Created by Akash Malhotra on 19/12/20.
//  Copyright © 2020 Akash Malhotra. All rights reserved.
//

import Foundation
import UIKit

class Loader {
    
    private static var loaderAlert: UIAlertController!
        
    static func showLoader(in vc: UIViewController) {
        loaderAlert = UIAlertController(title: nil, message: "Loading", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        loaderAlert.view.addSubview(loadingIndicator)
        vc.present(loaderAlert, animated: true, completion: nil)
    }
    
    static func hideLoader() {
        DispatchQueue.main.async {
            self.loaderAlert.dismiss(animated: true, completion: nil)
        }
    }
    
}
