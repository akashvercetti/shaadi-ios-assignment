//
//  HomeViewController.swift
//  Shaadi Assignment MVVM
//
//  Created by Akash Malhotra on 16/12/20.
//  Copyright © 2020 Akash Malhotra. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    class func instantiateFromStoryboard() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! HomeViewController
    }
    
    @IBOutlet weak var tvUsers: UITableView!
    
    private let viewModel = HomeViewModel()
    var displayedUsers: [HomeViewModel.DisplayedUser] = []
    
    // MARK: VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViews()
        
        super.showIndicator()
        viewModel.fetchUsers()
    }
    
    // MARK: UI
    func setupUI() {
        tvUsers.register(UINib.init(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        tvUsers.estimatedRowHeight = 100
        tvUsers.sectionHeaderHeight = UITableView.automaticDimension
    }
    
    // MARK: BINDING VIEWS
    func bindViews() {
        viewModel.displayedUsers.bind { [weak self] displayedUsers in
            self?.hideIndicator()
            self?.displayedUsers = displayedUsers
            self?.tvUsers.reloadData()
        }
        
        viewModel.networkError.bind { [weak self] error in
            if let _ = error {
                self?.showError()
            }
        }
    }
}

// MARK: TABLE VIEW
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        let displayedUser = displayedUsers[indexPath.row]
        
        cell.lblName.text = displayedUser.DisplayedName
        cell.lblFavorite.text = displayedUser.DisplayedFavoriteText
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = viewModel.users[indexPath.row]
        let vc = UserDetailViewController.instantiateFromStoryboard()
        vc.user = selectedUser
        vc.starDelegate = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
}


