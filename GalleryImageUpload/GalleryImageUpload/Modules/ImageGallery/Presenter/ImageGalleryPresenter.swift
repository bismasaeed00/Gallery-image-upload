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

class ImageGalleryPresenter {
    var imagePicker: ImagePicker?
    var viewController: ImageGalleryViewController?
    let firebaseManager: FirebaseManager?
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy-HH-mm-ss"
        return formatter
    }
    
    init(viewController: ImageGalleryViewController) {
        self.viewController = viewController
        // Injecting storage and database references to FirebaseManager
        self.firebaseManager = FirebaseManager.init(storageReference: Storage.storage().reference(), databaseReference: Database.database().reference())
        self.imagePicker = ImagePicker(presentationController: self.viewController, delegate: self)
        fetchGalleryData()
    }
    
    func fetchGalleryData() {
        firebaseManager?.fetchAllImages()
    }
    private func storageTimeStamp() -> String{
        return "images/" + dateFormatter.string(from: Date()) + ".jpg"
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
        firebaseManager?.uploadDataToFirebase(dataToUpload: imageData, uploadPath: storageTimeStamp(), progress: { progress in
            //TODO: handle progress
            
        }, completion: { success, error  in
            //TODO: handle success/error
        })
        //TODO: add progress block
    }
}
