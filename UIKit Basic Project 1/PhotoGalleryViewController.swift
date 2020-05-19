//
//  PhotoGalleryViewController.swift
//  UIKit Basic Project 1
//
//  Created by Asal Macbook 1 on 18/05/2020.
//  Copyright © 2020 Mustafa Birat. All rights reserved.
//

import UIKit

class PhotoGalleryViewController: UIViewController {
  
  @IBOutlet var collectionView: UICollectionView!
  
  private var photos: [String] = ["mustafa1", "mustafa2", "mustafa3", "mustafa4", "mustafa5"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.register(UINib(nibName: "photoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "photoCell")
    collectionView.dataSource = self
    
    let layout = UICollectionViewFlowLayout()
    collectionView.collectionViewLayout = layout
    layout.itemSize = CGSize(width: CGFloat(floor(self.view.frame.width / 2) - (16.0 * 2)), height: CGFloat(floor(self.view.frame.width / 2) - (16.0 * 2)))
    
  }
  
  
}



extension PhotoGalleryViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! photoCollectionViewCell
    cell.loadImage(photos[indexPath.row])
    
    return cell
  }
  
  
  
}



