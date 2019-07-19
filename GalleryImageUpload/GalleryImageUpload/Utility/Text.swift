//
//  Text.swift
//  GalleryImageUpload
//
//  Created by Bisma Saeed on 18.07.19.
//  Copyright © 2019 Bisma Saeed. All rights reserved.
//

import Foundation
enum Text {
    enum Alert {
        static let cancelBtnTitle = "Cancel"
        static let photoBtnTitle = "Photos"
        static let cameraBtnTitle = "Camera"
        static let title = "Select"
        static let message = "Please select source of the photo."
    }
    enum CellIdentifiers {
        static let imageGalleryCell = "ImageGalleryCell"
    }
    enum Image {
        static let imageFolderName = "images/"
        static let imageExtension = ".jpg"
    }
    enum Database {
        static let imageUrl = "imageUrl"
        static let imageTimeStamp = "createdAt"
    }
}
