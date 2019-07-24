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
    
    private let storage : Storage
    private let database: Database

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy-HH-mm-ss"
        return formatter
    }
    
    /**
     Initialize FirebaseManager.
     - Parameters:
        - storage: Reference to storage instance of Firebase
        - database: Reference to the database instance of Firebase
     */
    init(storage: Storage = Storage.storage(), database: Database = Database.database()) {
        self.storage = storage
        self.database = database
    }
    
    private func getChildNameForImages() -> String{
        return "Images/"
    }
    
    /**
     Convert date to string.
     - Parameters:
        - date: Date value
     - returns: Converted date string
     */
    func dateToTimeStampString(date: Date) -> String{
        return dateFormatter.string(from: date)
    }
    
    /**
     Convert string to date.
     - Parameters:
        - string: string value of date.
     - returns: Converted date from string timestamp.
     */
    func timeStampToDate(string: String) -> Date?{
        return dateFormatter.date(from: string)
    }
    //MARK: Read data
    /**
     Observer for all the images from database, including the newly added.
     - Parameters:
        - completion: Image object or error in case of failure.
     */
    func fetchAllImages(completion: @escaping CompletionSuccessWithImage) {
        let nodeReference = database.reference().child(getChildNameForImages())
        nodeReference.observe(.childAdded, with: { (snapshot) -> Void in
            self.getImageDataFromChild(child: snapshot, completion: completion)
        })
    }
    
    private func getImageDataFromChild(child: Any, completion: @escaping CompletionSuccessWithImage) {
        
        guard let childSnap = child as? DataSnapshot, let childValue = childSnap.value as? [String:String], let urlString = childValue[Text.Database.imageUrl], let timeStamp = childValue[Text.Database.imageTimeStamp] else { return }
        
        // getting the URL paths for downloading images from Firebase storage.
        self.downloadUrlForReference(urlPath: urlString,timeStamp: timeStamp, completion: completion)
    }
    
    private func downloadUrlForReference(urlPath: String, timeStamp: String, completion: @escaping CompletionSuccessWithImage) {
        
        let urlReference = storage.reference(forURL: urlPath)
        urlReference.downloadURL { url, error in
            guard let imageUrl = url, let createdAt = self.timeStampToDate(string: timeStamp) else {
                completion(nil, error)
                return
            }
            let imageModel = ImageModel(imageUrl: imageUrl, createdAt: createdAt)
            // called completion block after receiving the image object or error
            completion(imageModel, error)
        }
    }
    
    //MARK: Write Data
    /**
     Add new image to Firebase storage.
     - Parameters:
        - dataToUpload: Image binary data
        - uploadPath: unique path from timestamp
        - progress: progress of upload
        - completion: completion block at the end of upload
     */
    func uploadDataToFirebase(dataToUpload: Data, uploadPath: String, timeStamp: String, progress: @escaping Progress, completion: @escaping CompletionSuccess) {
        
        // put data to storage
        let imageRef = storage.reference().child(uploadPath)
        let uploadTask = imageRef.putData(dataToUpload, metadata: nil, completion: { (metadata, error) in
            guard metadata != nil else {
                return completion(false ,error)
            }
            // get URL from the storage
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return completion(false ,error)
                }
                // save image info in Database
                self.saveDataUrlToFirebase(urlString: downloadURL.absoluteString, timeStamp: timeStamp, completion: completion)
            }
            return completion(true ,nil)
        })
        // progress of the upload
        uploadTask.observe(.progress) { snapshot in
            progress(snapshot.progress?.fractionCompleted)
        }
    }
    
    /**
     Save data with url information to Firebase Database.
     - Parameters:
        - urlString: path url to image storage
        - timeStamp: current timestamp for sorting the images
        - completion: completion block at the end of upload
     */
    func saveDataUrlToFirebase(urlString: String, timeStamp: String, completion: @escaping CompletionSuccess) {
        
        let uploadDictionary: [String: String] = [Text.Database.imageTimeStamp: timeStamp, Text.Database.imageUrl: urlString]
        let newChildRef = self.database.reference().child(getChildNameForImages()).childByAutoId()
        newChildRef.setValue(uploadDictionary, withCompletionBlock: {error, databaseRef in
            completion(error != nil ,error)
        })
    }
}
