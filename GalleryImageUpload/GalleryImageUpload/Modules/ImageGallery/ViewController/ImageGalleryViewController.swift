//
//  ImageGalleryViewController.swift
//  GalleryImageUpload
//
//  Created by Bisma Saeed on 18.07.19.
//  Copyright © 2019 Bisma Saeed. All rights reserved.
//

import UIKit
import Firebase

class ImageGalleryViewController: UIViewController {

    @IBOutlet weak var galleryCollectionView: UICollectionView?
    var presenter: ImageGalleryPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let firebaseManager = FirebaseManager.init(storage: Storage.storage(), databaseReference: Database.database().reference())
        presenter = ImageGalleryPresenter(viewController: self, firebaseManager: firebaseManager)
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
