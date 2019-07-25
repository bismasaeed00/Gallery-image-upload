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

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var galleryCollectionView: UICollectionView?
    var presenter: ImageGalleryPresenter?
    let cellHeight: CGFloat = 150
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let firebaseManager = FirebaseManager.init()
        presenter = ImageGalleryPresenter(viewController: self, firebaseManager: firebaseManager)
        galleryCollectionView?.dataSource = presenter
        galleryCollectionView?.register(UINib(nibName: Text.CellIdentifiers.imageGalleryCell,
                                              bundle: nil),
                                        forCellWithReuseIdentifier: Text.CellIdentifiers.imageGalleryCell)
        setCollectionViewLayout()
        setProgressView(value: 0, show: false)
    }
    
    private func setCollectionViewLayout() {
        
        // Setting cell size dynamically to present one cell in each row
        let layout = galleryCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let screenWidth = UIScreen.main.bounds.size.width
        let paddingSpace = layout.minimumInteritemSpacing
        let useableWidth = screenWidth - paddingSpace
        let cellSize = CGSize(width: useableWidth, height: cellHeight)
        
        layout.itemSize = cellSize
    }
    
    /**
     Reload the collection view
     */
    func reloadCollctionView(){
        galleryCollectionView?.reloadData()
    }
    
    /**
     Update progress view
     */
    func setProgressView(value: Float, show: Bool){
        progressView.isHidden = !show
        progressView.setProgress(value, animated: true)
    }
    
    //MARK: User Actions
    @IBAction private func addNewImageButtonTapped() {
        presenter?.addNewImagePressed()
    }
}
