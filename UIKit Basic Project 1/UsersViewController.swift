//
//  ViewController.swift
//  UIKit Basic Project 1
//
//  Created by Asal Macbook 1 on 17/05/2020.
//  Copyright © 2020 Mustafa Birat. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView! {
        
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var users: [User] = []
    private var filteredUsers: [User] = [] {
        
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.removeFromSuperview()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.frame = view.bounds
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        initUsersRequest()
        initSearchBarController()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserDetailsViewController {
            if let selectedIndex = tableView.indexPathForSelectedRow {
                let user = filteredUsers[selectedIndex.row]
                destination.user = user
            }
        }
    }
    
    
    private func initUsersRequest() {
        let usersRequest = UsersRequest()
        usersRequest.getUsers() { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let users):
                self?.filteredUsers = users
                self?.users = users
            }
        }
    }
    
    private func initSearchBarController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Users"
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
    
}

extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) {(_,_, completionHandler) in
            self.filteredUsers.remove(at: indexPath.row)
            self.tableView.reloadData()
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}


extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellWithSubTitles", for: indexPath) as? CellWithSubTitles
        cell?.loadUser(filteredUsers[indexPath.row], row: indexPath.row)
        return cell ?? UITableViewCell()
    }
}

extension UsersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let username  = searchController.searchBar.text else {
            filteredUsers = users
            return
        }
        if username == "" {
            filteredUsers = users
            return
        }
        self.filteredUsers = users.filter({$0.username.lowercased().hasPrefix(username.lowercased())})
    }
}
