//
//  cellWithSubTitle.swift
//  UIKit Basic Project 1
//
//  Created by Asal Macbook 1 on 19/05/2020.
//  Copyright © 2020 Mustafa Birat. All rights reserved.
//

import UIKit

class CellWithSubTitle: UITableViewCell {

  
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var companyName: UILabel!
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadUser(_ user: User) {
        title.text = user.username
        subtitle.text = user.email
    }
    
}
