//
//  FirebaseManager.swift
//  GalleryImageUpload
//
//  Created by Bisma Saeed on 18.07.19.
//  Copyright © 2019 Bisma Saeed. All rights reserved.
//

import Foundation
import Firebase

typealias Completion = (Bool, Error?) -> Void
typealias Progress = (Double?) -> Void
class FirebaseManager {
    
    let storageReference : StorageReference
    let databaseReference: DatabaseReference
    var data = Data()
    
    init(storageReference: StorageReference, databaseReference: DatabaseReference) {
        self.storageReference = storageReference
        self.databaseReference = databaseReference
    }
    
    func fetchAllImages() {
        let dbRef = storageReference.child("images")
        dbRef.downloadURL { url, error in
            if let error = error {
                // Handle any errors
            } else {
                // Get the download URL for 'images/stars.jpg'
            }
        }
    }
    
    //MARK: Write Data
    func uploadDataToFirebase(dataToUpload: Data, uploadPath: String, progress: @escaping Progress, completion: @escaping Completion) {
        let imageRef = storageReference.child(uploadPath)
        let uploadTask = imageRef.putData(dataToUpload, metadata: nil, completion: { (metadata, error) in
            guard metadata != nil else {
                return completion(false ,error)
            }
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return completion(false ,error)
                }
                self.saveDataUrlToFirebase(urlString: downloadURL.absoluteString, completion: completion)
            }
            return completion(true ,nil)
        })
        uploadTask.observe(.progress) { snapshot in
            progress(snapshot.progress?.fractionCompleted)
        }
    }
    
    func saveDataUrlToFirebase(urlString: String, completion: @escaping Completion) {
        let dbRef = self.databaseReference.child("Images/")
        dbRef.setValue(urlString, withCompletionBlock: {error, databaseRef in
            completion(error != nil ,error)
        })
    }
}
