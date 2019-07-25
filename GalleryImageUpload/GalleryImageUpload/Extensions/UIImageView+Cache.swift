//
//  UIImageView+Cache.swift
//  GalleryImageUpload
//
//  Created by Bisma Saeed on 20.07.19.
//  Copyright © 2019 Bisma Saeed. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

let imageCache = AutoPurgingImageCache( memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)

extension UIImageView {
    /**
    Load image from cache, if does not exist then load it from Url path and store it in the cache.
    - Parameters:
      - urlString: Image url string
      - completion: Success block on the completion of the loading process
    */
    func loadImageCacheWithUrlString(urlString: String,  completion: @escaping CompletionSuccess) {
        
        if let image = imageCache.image(withIdentifier: urlString) {
            self.image = image
            completion(true, nil)
        } else {
            getImage(urlString: urlString, completion: completion)
        }
    }
    
//    Load image from Firebase storage and store it into NSCache
    private func getImage(urlString: String, completion: @escaping CompletionSuccess) {
        
        Alamofire.request(urlString).responseImage { response in
            guard let imageData = response.data, let image = UIImage(data: imageData, scale: 1.0) else {
                completion(false, response.error)
                return
            }
            
            imageCache.add(image, withIdentifier: urlString)
            self.image = image
            completion(true, nil)
        }
    }
}
