//
//  ViewController.swift
//  UIKit Basic Project 1
//
//  Created by Asal Macbook 1 on 17/05/2020.
//  Copyright © 2020 Mustafa Birat. All rights reserved.
//

import AppKit

class UsersViewController: NSViewController {
    
    
    @IBOutlet var tableView: NSTableView! {
        
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.target = self
            tableView.doubleAction = #selector(rowDoubleClicked)
        }
    }
    
    private var usersViewModel: UsersViewModel = UsersViewModel(usersRequest: ApiUsersRequest())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        fetchUsers()
    }
    
    private func fetchUsers() {
        usersViewModel.fetchUsers { [weak self] users in
            DispatchQueue.main.async {[weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc func rowDoubleClicked() {
        let mainStoryboard = NSStoryboard(name: "Main", bundle: nil)
        guard let detailedWindow = mainStoryboard.instantiateController(withIdentifier: "detailsWindow") as? NSWindowController else {return}
        
        guard let detailedViewController = detailedWindow.contentViewController as? UserDetailsViewController else {return}
        guard let selectedUserIndex = tableView.selectedRowIndexes.first else {return}
        detailedViewController.user = usersViewModel.filteredUsers[selectedUserIndex]
        detailedWindow.showWindow(self)
    }
}

extension UsersViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let cellId = NSUserInterfaceItemIdentifier(rawValue: Identifires.userCell.rawValue)
        guard let cell = tableView.makeView(withIdentifier: cellId , owner: self) as? NSTableCellView else {
            return nil
        }
        
        if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: Identifires.usernameColumn.rawValue) {
            cell.textField?.stringValue = usersViewModel.filteredUsers[row].username
        } else if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: Identifires.emailColumn.rawValue) {
            cell.textField?.stringValue = usersViewModel.filteredUsers[row].email
        }
        
        if row % 2 == 0, tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: Identifires.companyColumn.rawValue){
            cell.textField?.stringValue = usersViewModel.filteredUsers[row].company.name
        }
        
        return cell
    }
}

extension UsersViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        usersViewModel.filteredUsers.count
    }
}


enum Identifires: String {
    case userCell, usernameColumn, emailColumn, companyColumn
}
