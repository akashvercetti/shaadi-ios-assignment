//
//  UserDetailViewController.swift
//  Shaadi Assignment Clean Architecture
//
//  Created by Akash Malhotra on 15/12/20.
//  Copyright (c) 2020 Akash Malhotra. All rights reserved.
//


import UIKit

protocol UserDetailViewControllerInput {
    
    func displayLoader(type: UserDetailLoaderType)
    func hideLoader(type: UserDetailLoaderType)
    func displayError(type: UserDetailErrorType)
    func displayUserDetail(viewModel: UserDetailModels.FetchDetails.ViewModel)
}

class UserDetailViewController: BaseViewController, UserDetailViewControllerInput {
    
    class func instantiateFromStoryboard() -> UserDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! UserDetailViewController
    }
    
    var output: UserDetailInteractorInput!
    var router: UserDetailRouterInput!
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var lblCompany: UILabel!
    @IBOutlet var lblPhone: UILabel!
    @IBOutlet var lblWebsite: UILabel!
    @IBOutlet var lblFavorite: UILabel!
    var starButton = UIButton()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UserDetailConfigurator.sharedInstance.configure(viewController: self)
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        output.fetchUserDetail(request: UserDetailModels.FetchDetails.Request())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func displayLoader(type: UserDetailLoaderType) {
        
    }
    
    func hideLoader(type: UserDetailLoaderType) {
        
    }
    
    func displayError(type: UserDetailErrorType) {
        
    }
    
    func setupUI() {
        
        starButton =  UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
        starButton.setTitle("❤️", for: .normal)
        starButton.setTitle("💔", for: .selected)
        starButton.addTarget(self, action: #selector(starUser), for: .touchUpInside)
        starButton.isSelected = output.user.isFavorite ?? false
        let barButton = UIBarButtonItem(customView: starButton)
        navigationItem.rightBarButtonItem = barButton
        
        starButton.isAccessibilityElement = true
        starButton.accessibilityIdentifier = "btnStar"
        starButton.accessibilityLabel = "btnStar"
    }
    
    func displayUserDetail(viewModel: UserDetailModels.FetchDetails.ViewModel) {
        lblName.text = viewModel.DisplayedName
        lblUserName.text = viewModel.DisplayedUserName
        lblAddress.text = viewModel.DisplayedAddress
        lblCompany.text = viewModel.DisplayedCompany
        lblPhone.text = viewModel.DisplayedPhone
        lblWebsite.text = viewModel.DisplayedWebsite
        lblFavorite.text = viewModel.DisplayedFavoriteText
    }
    
    @objc func starUser() {
        starButton.isSelected = !starButton.isSelected
        output.starUser(request: UserDetailModels.StarUser.Request(MarkFavorite: starButton.isSelected))
        
        guard let id = output.user.id else {
            return
        }
        output.starDelegate?.userMarked(isFavorite: starButton.isSelected, id: id)
    }
}
