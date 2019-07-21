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
    
    init(imageUrl: URL, createdAt: Date) {
        self.imageUrl = imageUrl
        self.createdAt = createdAt
    }
}
