//
//  ImageLoader.swift
//  Basic Mac App
//
//  Created by Asal Macbook 1 on 10/06/2020.
//  Copyright © 2020 Mustafa Birat. All rights reserved.
//

import AppKit


extension NSImageView {
    func setImage(_ urlStr: String){
        guard let imageURL = URL(string: urlStr) else {return}
        
        DispatchQueue.global(qos: .userInitiated).async {
            do{
                let imageData: Data = try Data(contentsOf: imageURL)
                DispatchQueue.main.async {
                    let image = NSImage(data: imageData)
                    self.image = image
                    self.sizeToFit()
                }
            }catch{
                print("Unable to load data: \(error)")
            }
        }
    }
}
