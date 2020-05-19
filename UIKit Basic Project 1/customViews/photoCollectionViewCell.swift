//
//  photoCollectionViewCell.swift
//  UIKit Basic Project 1
//
//  Created by Asal Macbook 1 on 19/05/2020.
//  Copyright © 2020 Mustafa Birat. All rights reserved.
//

import UIKit

class photoCollectionViewCell: UICollectionViewCell {

  @IBOutlet var photo: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }

  func loadImage(_ name: String) {
    photo.image = UIImage(named: name )
  }
  
}
