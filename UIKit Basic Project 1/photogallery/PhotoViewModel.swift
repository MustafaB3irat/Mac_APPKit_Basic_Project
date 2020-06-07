//
//  PhotoViewModel.swift
//  UIKit Basic Project 1
//
//  Created by Asal Macbook 1 on 07/06/2020.
//  Copyright © 2020 Mustafa Birat. All rights reserved.
//

import UIKit

class PhotoViewModel {
    
    var albums: [Int: [Photo]]
    var photosRequest: PhotosRequest
    
    init(photosRequest: PhotosRequest) {
        albums = [:]
        self.photosRequest = photosRequest
    }
    
    func fetchPhotos(completion: @escaping (Bool) -> Void) {
        photosRequest.getPhotos() { [weak self] response in
            switch response {
            case .failure(let error):
                print(error)
                completion(false)
            case .success(let photos):
                for photo in photos {
                    self?.albums[photo.albumId] == nil ? self?.albums[photo.albumId] = [photo] : self?.albums[photo.albumId]?.append(photo)
                }
                completion(true)
            }
        }
    }
}
