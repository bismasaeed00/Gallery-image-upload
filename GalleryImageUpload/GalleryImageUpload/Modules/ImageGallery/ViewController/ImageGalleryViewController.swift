//
//  ImageGalleryViewController.swift
//  GalleryImageUpload
//
//  Created by Bisma Saeed on 18.07.19.
//  Copyright © 2019 Bisma Saeed. All rights reserved.
//

import UIKit

class ImageGalleryViewController: UIViewController {

    @IBOutlet private weak var galleryCollectionView: UICollectionView?
    var presenter: ImageGalleryPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ImageGalleryPresenter(viewController: self)
    }
    
    //MARK: User Actions
    @IBAction private func addNewImageButtonTapped() {
        presenter?.addNewImagePressed()
    }
}

extension ImageGalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //TODO: open full image
    }
}
