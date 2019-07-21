//
//  ImageModel.swift
//  GalleryImageUpload
//
//  Created by Bisma Saeed on 19.07.19.
//  Copyright © 2019 Bisma Saeed. All rights reserved.
//

import Foundation
struct ImageModel {
    var imageUrl: URL
    var createdAt: Date
    
    /**
     Initialize new ImageModel.
     - Parameters:
        - imageUrl: url to the image storage
        - createdAt: uploading date of the image
     */
    init(imageUrl: URL, createdAt: Date) {
        self.imageUrl = imageUrl
        self.createdAt = createdAt
    }
}
