//
//  ViewController.swift
//  UIKit Basic Project 1
//
//  Created by Asal Macbook 1 on 17/05/2020.
//  Copyright © 2020 Mustafa Birat. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {

  @IBOutlet var tableView: UITableView!
  
  private var users: [User] = [
    User(username: "Steve Rog", fullName: "Steve Rogers", email: "ste@gmail.com", website: "steveblocg.hitachi.com", phone: "817834765"),
     User(username: "Stefany lat", fullName: "Stefany snow lati", email: "stef@gmail.com", website: "stefanyblog.hitachi.com", phone: "817234213"),
      User(username: "Zak trels", fullName: "Zack jack trels", email: "zack98@hotmail.com", website: "zackx.hitachi.com", phone: "718564776"),
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let nib = UINib(nibName: "cellWithSubTitle", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: "cellWithSubTitle")
    
    tableView.delegate = self
    tableView.dataSource = self
   
  }
}

extension UsersViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let detailedUser = storyboard?.instantiateViewController(identifier: "userdetails") as! UserDetailsViewController
    detailedUser.user = users[indexPath.row]
    navigationController?.pushViewController(detailedUser, animated: true)
    
  }
  
}

extension UsersViewController: UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithSubTitle", for: indexPath) as! cellWithSubTitle
    cell.title.text = users[indexPath.row].username
    cell.subtitle.text = users[indexPath.row].email
    
    return cell
  }
  
}

