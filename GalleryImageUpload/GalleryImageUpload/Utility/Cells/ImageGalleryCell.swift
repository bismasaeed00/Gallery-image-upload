//
//  ImageGalleryCell.swift
//  GalleryImageUpload
//
//  Created by Bisma Saeed on 19.07.19.
//  Copyright © 2019 Bisma Saeed. All rights reserved.
//

import UIKit

class ImageGalleryCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView?
    
    // Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        makeFreshView()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        makeFreshView()
    }
    
    private func makeFreshView() {
        imageView?.image = nil
        loadingMode(loadingMode: false)
    }
    
    private func loadingMode(loadingMode: Bool) {
        loadingMode ? loadingIndicator?.startAnimating() : loadingIndicator?.stopAnimating()
    }
    
    func setupCellData(model: ImageModel) {
        loadingMode(loadingMode: true)
        CacheManager().downloadImage(url: model.imageUrl) { (image, error) in
            self.imageView?.image = image
            self.loadingMode(loadingMode: false)
        }
    }
}
