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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeFreshView()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        makeFreshView()
    }
    /// Setting up all the views to fresh state
    private func makeFreshView() {
        imageView?.image = nil
        loadingMode(loadingMode: false)
    }
    
    /// Enable or Disable loading mode
    private func loadingMode(loadingMode: Bool) {
        loadingMode ? loadingIndicator?.startAnimating() : loadingIndicator?.stopAnimating()
    }
    
    /**
     Populate cell with the model data.
     - Parameters:
        - model: Image model to setup this cell
     */
    func setupCellData(model: ImageModel) {
        loadingMode(loadingMode: true)
        self.imageView?.loadImageCacheWithUrlString(urlString: model.imageUrl.absoluteString, completion: { success, error in
            self.loadingMode(loadingMode: false)
        })
    }
}
