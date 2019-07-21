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

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    
    func loadImageCacheWithUrlString(urlString: String,  completion: @escaping CompletionSuccess) {
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString){
            self.image = cachedImage
            completion(true, nil)
        } else {
            getImage(urlString: urlString, completion: completion)
        }
    }
    
    private func getImage(urlString: String, completion: @escaping CompletionSuccess) {
        
        Alamofire.request(urlString, method: .get).responseImage { response in
            if let downloadedImage = response.result.value {
                imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                self.image = downloadedImage
                completion(true, nil)
            }else{
                self.image = nil
                completion(false, response.error)
            }
        }
    }
}
