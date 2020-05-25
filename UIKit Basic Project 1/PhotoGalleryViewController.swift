//
//  PhotoGalleryViewController.swift
//  UIKit Basic Project 1
//
//  Created by Asal Macbook 1 on 18/05/2020.
//  Copyright © 2020 Mustafa Birat. All rights reserved.
//

import UIKit

class PhotoGalleryViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "photoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "photoCell")
            collectionView.dataSource = self
        collectionView.delegate = self
        }
    }
    
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    private var albums: [Int: [Photo]]  = [:] {
        
        didSet {
            collectionView.reloadData()
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    override func viewDidLoad() {
        activityIndicator.frame = view.bounds
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        super.viewDidLoad()
        initPhotosRequest()
    }
    
    func initPhotosRequest() {
        let photosRequest = PhotosRequest()
        
        photosRequest.getPhotos() { [weak self] response in
            
            switch response {
            case .failure(let error):
                print(error)
            case .success(let albums):
                self?.albums = albums
            }
            
        }
    }
}



extension PhotoGalleryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return albums.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums[section + 1]?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? photoCollectionViewCell
        guard let album = albums[indexPath.section + 1] else {return UICollectionViewCell()}
        cell?.photo.setNetworkImage(album[indexPath.item].thumbnailUrl)
        
        return cell ?? UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let albumHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "albumHeader", for: indexPath) as! AlbumHeader
        
        albumHeader.albumId.text = "\(indexPath.section + 1)"
        return albumHeader
    }
    
}

extension PhotoGalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: CGFloat(floor(self.view.frame.width / 2) - (16.0 * 2)), height: CGFloat(floor(self.view.frame.width / 2) - (16.0 * 2)))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }

}


extension PhotoGalleryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let newImageView = UIImageView()
        guard let album = albums[indexPath.section + 1] else {return}
        newImageView.setNetworkImage(album[indexPath.item].url)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}

extension UIImageView {
    
    func setNetworkImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "default")
            return
        }
        DispatchQueue.global().async { [weak self] in
            guard let url = URL(string: imageURLString) else {return}
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                guard let photoData = data else {
                    self?.image = UIImage(named: "default")
                    return
                }
                self?.image = UIImage(data: photoData)
            }
        }
    }
}


