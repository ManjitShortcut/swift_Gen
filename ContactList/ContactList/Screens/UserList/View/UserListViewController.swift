//
//  UserListViewController.swift
//  DNB_TASK
//
//  Created by Manjit on 24/03/2021.
//

import UIKit

class UserListViewController: UIViewController,ViewControllerIntilization {
    
    let navigator: UserListNavigator?
    internal var theme: UserListTheme
    internal var viewModel: UserListViewModel
    fileprivate lazy var isFavItemDeleted: Bool =  false
    internal lazy var userTableView: UITableView = {
        let tableView = UITableView.init()
        tableView.backgroundColor = UIColor.clear
        tableView.tableFooterView = UIView.init()
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // MARK: View controller lifecycle
    init(navigator: UserListNavigator?, viewModel: UserListViewModel, theme: UserListTheme ) {
        self.navigator = navigator
        self.viewModel = viewModel
        self.theme = theme
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
        if isFavItemDeleted == true {
            userTableView.reloadData()
            isFavItemDeleted = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = theme.backGroundColor
        self.title = "User List"
        //TODO need to used in viewmodel not here
        NotificationCenter.default.addObserver(self, selector: #selector(self.deleteFavoriteUser(_:)), name: Notification.Name(rawValue: "deleteFavoriteItem") , object: nil)
        self.setFavoriteButton()
        self.designUI()
        fetchingUserList()
        // Do any additional setup after loading the view.
    }
    // MARK: Notify when user delete the object from favorite list
    // handle notification
    @objc func deleteFavoriteUser(_ notification: Notification) {
        if let dict = notification.userInfo as Dictionary? {
               if let favInfo = dict["deleteFavInfo"] as? UserInfo {
                 viewModel.removeFavoriteItem(item: favInfo)
                isFavItemDeleted = true
               }
           }
    }
    // MARK: Set favorite button on navigation bar
    fileprivate func setFavoriteButton() {
        let favorite =  UIBarButtonItem(title: "favourite", style: .plain, target: self, action: #selector(addTapped))
        favorite.tintColor = UIColor().textDisplayColor
        self.navigationItem.rightBarButtonItem = favorite
    }
    @objc fileprivate func addTapped() {
        navigator?.navigate(to: .favoriteList(favoriteList: viewModel.getFavItemList()))
    }
    // MARK: Design UI
    internal func designUI() {
        self.userTableView.delegate = self
        self.userTableView.dataSource = self
        userTableView.register(UINib(nibName: "UserInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "userInfoCell")
        self.userTableView.rowHeight = UITableView.automaticDimension
        self.userTableView.estimatedRowHeight = 50.0; // set to whatever your "average" cell height is
        self.view.addSubview(userTableView)
        userTableView.equalAndCenter(to: self.view)
    }
    // MARK: fetching userList
    fileprivate func fetchingUserList() {
        viewModel.loadingStateCallback = { [weak self] status in
            self?.hideLoader()
            switch status {
            case .loading:
                self?.showLoader()
            case .failed(let error):
                self?.showNetworkError(error,okAction: {
                    // perform task if neeeded
                })
            case  .loaded:
                self?.reloadTableView()
            default:
                break
            }
        }
        viewModel.onload()
    }
    // MARK: Reload table view
    // Reload  table view once the whole 
    fileprivate func reloadTableView() {
        DispatchQueue.main.async {
            self.userTableView.reloadData()
        }
    }
    func favItemSelected(_ identifier: String) {
        viewModel.addAndRemoveItemFromFavoriteList(for: identifier) { [weak self] (itemIndex) in
            if let index =  itemIndex {
                DispatchQueue.main.async {
                    self?.userTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                }
            }
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell", for: indexPath) as? UserInfoTableViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.itemforIndex(indexPath.row)
        cell.setfavIconSelected(selectedStatus: viewModel.favIconStatus(for: indexPath.row))
        cell.favItemCallback = { [weak self] item in
            DispatchQueue.main.async {
                self?.favItemSelected(item)
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: false)
    }
}
