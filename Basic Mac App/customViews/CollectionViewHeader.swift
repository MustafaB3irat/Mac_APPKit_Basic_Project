//
//  CollectionViewHeader.swift
//  Basic Mac App
//
//  Created by Asal Macbook 1 on 10/06/2020.
//  Copyright © 2020 Mustafa Birat. All rights reserved.
//

import Cocoa

class CollectionViewHeader: NSView {
    
    @IBOutlet private weak var albumId: NSTextField!
    func loadAlbumId(_ albumId: Int) {
        self.albumId.stringValue = "\(albumId)"
    }
    
}
