//
//  FavoriteViewController.swift
//  DNB_TASK
//
//  Created by Manjit on 02/04/2021.
//
import UIKit
class FavoriteViewController: UIViewController,ViewControllerIntilization {
    
    var viewModel: FavoriteListViewModel
    var theme: FavoritListTheme
    
    internal lazy var userTableView: UITableView = {
        let tableView = UITableView.init()
        tableView.backgroundColor = UIColor.clear
        tableView.tableFooterView = UIView.init()
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    init(viewModel:FavoriteListViewModel, theme: FavoritListTheme) {
        self.viewModel = viewModel
        self.theme =  theme
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = theme.backgroundColor
        self.title = "Favourites"
        self.designUI()
        // Do any additional setup after loading the view.
    }
    // MARK: Design UI
    func designUI() {
        self.userTableView.delegate = self
        self.userTableView.dataSource = self
        userTableView.register(UINib(nibName: "UserInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "userInfoCell")
        self.userTableView.rowHeight = UITableView.automaticDimension
        self.userTableView.estimatedRowHeight = 50.0; // set to whatever your "average" cell height is
        self.view.addSubview(userTableView)
        userTableView.equalAndCenter(to: self.view)
    }
}
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell", for: indexPath) as? UserInfoTableViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.itemforIndex(indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: false)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        viewModel.deleteFavoriteItem(for: indexPath.row) { [weak self] in
            self?.userTableView.deleteRows(at: [indexPath], with: .automatic)
        }
      }
    }
}
