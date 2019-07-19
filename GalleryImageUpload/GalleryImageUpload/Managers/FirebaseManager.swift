//
//  FirebaseManager.swift
//  GalleryImageUpload
//
//  Created by Bisma Saeed on 18.07.19.
//  Copyright © 2019 Bisma Saeed. All rights reserved.
//

import Foundation
import Firebase

typealias CompletionSuccess = (Bool, Error?) -> Void
typealias CompletionSuccessWithImage = (ImageModel?, Error?) -> Void
typealias Progress = (Double?) -> Void


class FirebaseManager {
    
    let storageReference : StorageReference
    let databaseReference: DatabaseReference
    var data = Data()
    
    init(storageReference: StorageReference, databaseReference: DatabaseReference) {
        self.storageReference = storageReference
        self.databaseReference = databaseReference
    }
    
    private func getChildNameForImages() -> String{
        return "Images/"
    }
    //MARK: Read data
    func fetchAllImages(completion: @escaping CompletionSuccessWithImage) {
        let nodeReference = databaseReference.child(getChildNameForImages())
        // Getting all the existing data
//        nodeReference.observeSingleEvent(of: .value, with: {snapshot in
//
//            guard snapshot.exists() else { return }
//
//            for child in snapshot.children{
//                self.getImageDateFromChild(child: child, completion: completion)
//            }
//        })
        
        // adding observer for new entries in database
        nodeReference.observe(.childAdded, with: { (snapshot) -> Void in
            self.getImageDateFromChild(child: snapshot, completion: completion)
        })
    }
    
    private func getImageDateFromChild(child: Any, completion: @escaping CompletionSuccessWithImage) {
        
        guard let childSnap = child as? DataSnapshot, let childValue = childSnap.value as? [String:String], let urlString = childValue[Text.Database.imageUrl], let timeStamp = childValue[Text.Database.imageTimeStamp] else { return }
        
        self.downloadUrlForReference(urlPath: urlString,timeStamp: timeStamp, completion: completion)
    }
    
    private func downloadUrlForReference(urlPath: String, timeStamp: String, completion: @escaping CompletionSuccessWithImage) {
        
        let urlReference = Storage.storage().reference(forURL: urlPath)
        urlReference.downloadURL { url, error in
            guard let imageUrl = url else {
                completion(nil, error)
                return
            }
            let imageModel = ImageModel(imageUrl: imageUrl, createdAt: timeStamp)
            completion(imageModel, error)
        }
    }
    
    //MARK: Write Data
    func uploadDataToFirebase(dataToUpload: Data, uploadPath: String, timeStamp: String, progress: @escaping Progress, completion: @escaping CompletionSuccess) {
        
        let imageRef = storageReference.child(uploadPath)
        let uploadTask = imageRef.putData(dataToUpload, metadata: nil, completion: { (metadata, error) in
            guard metadata != nil else {
                return completion(false ,error)
            }
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return completion(false ,error)
                }
                self.saveDataUrlToFirebase(urlString: downloadURL.absoluteString, timeStamp: timeStamp, completion: completion)
            }
            return completion(true ,nil)
        })
        uploadTask.observe(.progress) { snapshot in
            progress(snapshot.progress?.fractionCompleted)
        }
    }
    
    func saveDataUrlToFirebase(urlString: String, timeStamp: String, completion: @escaping CompletionSuccess) {
        
        let uploadDictionary: [String: String] = [Text.Database.imageTimeStamp: timeStamp, Text.Database.imageUrl: urlString]
        let newChildRef = self.databaseReference.child(getChildNameForImages()).childByAutoId()
        newChildRef.setValue(uploadDictionary, withCompletionBlock: {error, databaseRef in
            completion(error != nil ,error)
        })
    }
}
