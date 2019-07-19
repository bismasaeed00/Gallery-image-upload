//
//  ImageGalleryPresenter.swift
//  GalleryImageUpload
//
//  Created by Bisma Saeed on 18.07.19.
//  Copyright © 2019 Bisma Saeed. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ImageGalleryPresenter : NSObject{
    var imagePicker: ImagePicker?
    var viewController: ImageGalleryViewController?
    let firebaseManager: FirebaseManager?
    
    var imageList: [ImageModel] = []
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy-HH-mm-ss"
        return formatter
    }
    
    init(viewController: ImageGalleryViewController) {
        self.viewController = viewController
        // Injecting storage and database references to FirebaseManager
        self.firebaseManager = FirebaseManager.init(storageReference: Storage.storage().reference(), databaseReference: Database.database().reference())
        super.init()
        self.imagePicker = ImagePicker(presentationController: self.viewController, delegate: self)
        
        fetchGalleryData()
    }
    
    func fetchGalleryData() {
        firebaseManager?.fetchAllImages(completion: { imageModel, error in
            
            guard let image = imageModel else { return }
            self.imageList.append(image)
//            self.imageList.sort(by: { (modelOne, modelTwo) -> Bool in
//                return modelOne.createdAt > modelTwo.createdAt
//            })
            self.viewController?.reloadCollctionView()
        })
    }
    private func storageTimeStamp() -> String{
        return dateFormatter.string(from: Date())
    }
}

extension ImageGalleryPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: Text.CellIdentifiers.imageGalleryCell, for: indexPath) as! ImageGalleryCell
        imageCell.setupCellData(model: imageList[indexPath.item])
        return imageCell
    }
}

extension ImageGalleryPresenter: ImageGalleryPresenterProtocol{
    func addNewImagePressed() {
        guard let view = viewController?.view else { return }
        self.imagePicker?.present(from: view)
    }
}

extension ImageGalleryPresenter: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else { return }
        let timeStamp = storageTimeStamp()
        let uplaodPath = Text.Image.imageFolderName + timeStamp + Text.Image.imageExtension
        firebaseManager?.uploadDataToFirebase(dataToUpload: imageData, uploadPath: uplaodPath, timeStamp: timeStamp, progress: { progress in
            //TODO: handle progress
            
        }, completion: { success, error  in
            //TODO: handle success/error
        })
        //TODO: add progress block
    }
}
