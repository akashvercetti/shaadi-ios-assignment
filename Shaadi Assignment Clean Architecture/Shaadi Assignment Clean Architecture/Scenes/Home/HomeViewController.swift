//
//  HomeViewController.swift
//  Shaadi Assignment Clean Architecture
//
//  Created by Akash Malhotra on 15/12/20.
//  Copyright (c) 2020 Akash Malhotra. All rights reserved.
//


import UIKit

protocol HomeViewControllerInput {
    
    func displayLoader(type: HomeLoaderType)
    func hideLoader(type: HomeLoaderType)
    func displayError(type: HomeErrorType)
    func displayUsers(viewModel: HomeModels.FetchUser.ViewModel)
}

class HomeViewController: BaseViewController, HomeViewControllerInput {
    
    class func instantiateFromStoryboard() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! HomeViewController
    }
    
    var output: HomeInteractorInput!
    var router: HomeRouterInput!
    
    @IBOutlet weak var tvUsers: UITableView!
    
    var displayedUsers: [HomeModels.FetchUser.ViewModel.DisplayedUser] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        HomeConfigurator.sharedInstance.configure(viewController: self)
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        output.fetchUsers(request: HomeModels.FetchUser.Request())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func displayLoader(type: HomeLoaderType) {
        super.showIndicator()
    }
    
    func hideLoader(type: HomeLoaderType) {
        super.hideIndicator()
    }
    
    func displayError(type: HomeErrorType) {
        super.showError()
    }
    
    // MARK: UI
    func setupUI() {
        tvUsers.register(UINib.init(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        tvUsers.estimatedRowHeight = 100
        tvUsers.sectionHeaderHeight = UITableView.automaticDimension
    }
    
    func displayUsers(viewModel: HomeModels.FetchUser.ViewModel) {
        displayedUsers = viewModel.DisplayedUsers
        tvUsers.reloadData()
    }
}

// MARK: TableView
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
        let selectedUser = output.users[indexPath.row]
        router.navigateToUserDetails(user: selectedUser)
    }
}

// MARK: Mark as Favorite Protocol
extension HomeViewController: UserFavoriteProtocol {
    
    func userMarked(isFavorite: Bool, id: Int) {
        
        output.starUser(request: HomeModels.StarUser.Request(Id: id, IsFavorite: isFavorite))
    }
    
    
}
