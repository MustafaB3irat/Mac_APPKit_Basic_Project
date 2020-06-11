//
//  CollectionViewItem.swift
//  Basic Mac App
//
//  Created by Asal Macbook 1 on 10/06/2020.
//  Copyright © 2020 Mustafa Birat. All rights reserved.
//

import Cocoa

class CollectionViewItem: NSCollectionViewItem {

    @IBOutlet private weak var image: NSImageView!
    
    func loadImage(_ imageURL: String) {
        image.setImage(imageURL)
    }
}
