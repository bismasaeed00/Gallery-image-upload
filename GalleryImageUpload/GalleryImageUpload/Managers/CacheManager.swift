//
//  CacheManager.swift
//  GalleryImageUpload
//
//  Created by Bisma Saeed on 19.07.19.
//  Copyright © 2019 Bisma Saeed. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

/// This manager is responsable for
class CacheManager {
    
    let imageCache = NSCache<NSString, UIImage>()
    func downloadImage(url: URL, completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage, nil)
        } else {
            
            self.getImage(url.absoluteString) { image in
                
                if let imageValue = image {
                    self.imageCache.setObject(imageValue, forKey: url.absoluteString as NSString)
                }
                completion(image, nil)
            }
        }
    }
    
    private func getImage(_ url:String,handler: @escaping (UIImage?)->Void) {
        print(url)
        Alamofire.request(url, method: .get).responseImage { response in
            if let data = response.result.value {
                handler(data)
            } else {
                handler(nil)
            }
        }
    }
}
