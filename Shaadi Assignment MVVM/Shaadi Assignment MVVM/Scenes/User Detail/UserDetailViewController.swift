//
//  UserDetailViewController.swift
//  Shaadi Assignment MVVM
//
//  Created by Akash Malhotra on 17/12/20.
//  Copyright © 2020 Akash Malhotra. All rights reserved.
//

import UIKit

class UserDetailViewController: BaseViewController {
    
    class func instantiateFromStoryboard() -> UserDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! UserDetailViewController
    }
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var lblCompany: UILabel!
    @IBOutlet var lblPhone: UILabel!
    @IBOutlet var lblWebsite: UILabel!
    @IBOutlet var lblFavorite: UILabel!
    var starButton = UIButton()
    
    private let viewModel = UserDetailViewModel()
    var user: User?
    var starDelegate: UserFavoriteProtocol?
    
    // MARK: VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.user = user
        viewModel.loadUserValues()
        setupUI()
        bindViews()
        
    }
    
    // MARK: UI
    func setupUI() {
        starButton =  UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
        starButton.setTitle("❤️", for: .normal)
        starButton.setTitle("💔", for: .selected)
        starButton.addTarget(self, action: #selector(starUser), for: .touchUpInside)
        starButton.isSelected = viewModel.user?.isFavorite ?? false
        let barButton = UIBarButtonItem(customView: starButton)
        navigationItem.rightBarButtonItem = barButton
        
        starButton.isAccessibilityElement = true
        starButton.accessibilityIdentifier = "btnStar"
        starButton.accessibilityLabel = "btnStar"
    }
    
    // MARK: VIEW BINDING
    func bindViews() {
        viewModel.DisplayedName.bind { [weak self] name in
            self?.lblName.text = name
        }
        viewModel.DisplayedUserName.bind { [weak self] userName in
            self?.lblUserName.text = userName
        }
        viewModel.DisplayedAddress.bind { [weak self] address in
            self?.lblAddress.text = address
        }
        viewModel.DisplayedPhone.bind { [weak self] phone in
            self?.lblPhone.text = phone
        }
        viewModel.DisplayedAddress.bind { [weak self] address in
            self?.lblAddress.text = address
        }
        viewModel.DisplayedCompany.bind { [weak self] company in
            self?.lblCompany.text = company
        }
        viewModel.DisplayedWebsite.bind { [weak self] website in
            self?.lblWebsite.text = website
        }
        viewModel.DisplayedFavoriteText.bind { [weak self] favoriteText in
            self?.lblFavorite.text = favoriteText
        }
    }
    
    // MARK: MARK USER AS FAVORITE
    @objc func starUser() {
        starButton.isSelected = !starButton.isSelected
        viewModel.starUser(markFavorite: starButton.isSelected)
        
        guard let id = viewModel.user?.id else {
            return
        }
        starDelegate?.userMarked(isFavorite: starButton.isSelected, id: id)
    }
}
