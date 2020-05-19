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
        }
    }
    
    private var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUsersArr()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? UserDetailsViewController {
            destination.user = users[(tableView.indexPathForSelectedRow?.row)!]// it's sure that it will be called when a row is selected
        }
        
    }
    
    
    private func initUsersArr() {
        users = [
            User(username: "Steve Rog", fullName: "Steve Rogers", email: "ste@gmail.com", website: "steveblocg.hitachi.com", phone: "817834765"),
            User(username: "Stefany lat", fullName: "Stefany snow lati", email: "stef@gmail.com", website: "stefanyblog.hitachi.com", phone: "817234213"),
            User(username: "Zak trels", fullName: "Zack jack trels", email: "zack98@hotmail.com", website: "zackx.hitachi.com", phone: "718564776"),
        ]
    }
    
}


extension UsersViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellWithSubTitle", for: indexPath) as? cellWithSubTitle
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellWithSubTitle") as? cellWithSubTitle
        }
        
        cell?.title.text = users[indexPath.row].username
        cell?.subtitle.text = users[indexPath.row].email
        
        
        return cell!// it's sure that there will be a cell since there's a protoype so it's ok here ...
    }
    
}




