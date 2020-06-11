//
//  PhotoGalleryViewController.swift
//  UIKit Basic Project 1
//
//  Created by Asal Macbook 1 on 18/05/2020.
//  Copyright © 2020 Mustafa Birat. All rights reserved.
//

import AppKit

class PhotoGalleryViewController: NSViewController {
    
    @IBOutlet var collectionView: NSCollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    //    var activityIndicator = UIActivityIndicatorView(style: .large)
    //
    private var photosViewModel = PhotoViewModel(photosRequest: ApiPhotosRequest())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //activityIndicator.frame = view.bounds
        //  view.addSubview(activityIndicator)
        //  activityIndicator.startAnimating()
        initPhotosRequest()
    }
    
    func initPhotosRequest() {
        photosViewModel.fetchPhotos { [weak self] success in
            if success {
                DispatchQueue.main.async {[weak self] in
                    self?.collectionView.reloadData()
                    print("data is here")
                    //  self?.activityIndicator.stopAnimating()
                    // self?.activityIndicator.removeFromSuperview()
                }
            }
        }
    }
    //
    //    override func viewWillLayoutSubviews() {
    //        super.viewWillLayoutSubviews()
    //        collectionView.collectionViewLayout.invalidateLayout()
    //    }
}


//
//extension PhotoGalleryViewController: UICollectionViewDataSource {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return photosViewModel.albums.count
//    }
//
//
//    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
//        return photosViewModel.albums[section + 1]?.count ?? 0
//    }
//
//
//    func collectionView(_ collectionView: NSCollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell
//        guard let album = photosViewModel.albums[indexPath.section + 1] else {return UICollectionViewCell()}
//        cell?.loadImage(album[indexPath.item].thumbnailUrl)
//        return cell ?? UICollectionViewCell()
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        let albumHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "albumHeader", for: indexPath) as? AlbumHeader
//
//        albumHeader?.albumIdText = "\(indexPath.section + 1)"
//        return albumHeader ?? AlbumHeader()
//    }
//
//}
//
//extension PhotoGalleryViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = floor((self.collectionView.frame.width - 16.0 * 3) / 2)
//        return CGSize(width: width, height: width)
//    }
//}
//
//
//extension PhotoGalleryViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let album = photosViewModel.albums[indexPath.section + 1] else {return}
//        let vc = storyboard?.instantiateViewController(withIdentifier: "fullScreen") as? FullScreenPhotoViewController
//        vc?.imageURL = album[indexPath.item].url
//        vc?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        vc?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        guard let fullScreenViewController = vc else {return}
//        self.present(fullScreenViewController, animated: true)
//    }
//}


extension PhotoGalleryViewController: NSCollectionViewDelegate {
    
}

extension PhotoGalleryViewController: NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return photosViewModel.albums.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosViewModel.albums[section + 1]?.count ?? 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        guard let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CollectionViewItem"), for: indexPath) as? CollectionViewItem else {return NSCollectionViewItem()}
        
        guard let album = photosViewModel.albums[indexPath.section + 1] else {return NSCollectionViewItem()}
        
        item.loadImage(album[indexPath.item].thumbnailUrl)
        
        return item
        
    }
    
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: NSCollectionView.SupplementaryElementKind, at indexPath: IndexPath) -> NSView {
        guard let header = collectionView.makeSupplementaryView(ofKind: kind, withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CollectionViewHeader"), for: indexPath) as? CollectionViewHeader else {return NSView()}
        
        header.loadAlbumId(indexPath.section + 1)
        
        return header
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        guard let selectedIndexPath = indexPaths.first else {return}
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let fullScreenWindowController = storyboard.instantiateController(withIdentifier: "fullscreen") as? NSWindowController else {return}
       guard let fullScreenVC = fullScreenWindowController.contentViewController as? FullScreenPhotoViewController else {return}
        guard let album = photosViewModel.albums[selectedIndexPath.section + 1] else {return}
        fullScreenVC.imageURL = album[selectedIndexPath.item].url
        fullScreenWindowController.showWindow(self)
    }
}

extension PhotoGalleryViewController: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        let width = floor((view.frame.width - 32.0) / 2)
        return NSSize(width: width, height: width)
    }
}
