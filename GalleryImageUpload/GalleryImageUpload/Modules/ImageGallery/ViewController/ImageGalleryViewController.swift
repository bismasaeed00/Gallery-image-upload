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
        galleryCollectionView?.dataSource = presenter
        galleryCollectionView?.register(UINib(nibName: Text.CellIdentifiers.imageGalleryCell,
                                              bundle: nil),
                                        forCellWithReuseIdentifier: Text.CellIdentifiers.imageGalleryCell)
        setCollectionViewLayout()
    }
    
    private func setCollectionViewLayout() {
        
        // Setting cell size dynamically to present one cell in each row
        let layout = galleryCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let screenWidth = UIScreen.main.bounds.size.width
        let paddingSpace = layout.minimumInteritemSpacing
        let cellHeight: CGFloat = 150
        let useableWidth = screenWidth - paddingSpace
        let cellSize = CGSize(width: useableWidth, height: cellHeight)
        
        layout.itemSize = cellSize
    }
    func reloadCollctionView(){
        galleryCollectionView?.reloadData()
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
