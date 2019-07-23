//
//  FirebaseManagerTests.swift
//  GalleryImageUploadTests
//
//  Created by Bisma Saeed on 23.07.19.
//  Copyright © 2019 Bisma Saeed. All rights reserved.
//

import XCTest
import Firebase
@testable import GalleryImageUpload

//protocol Storage {
//
//}
//protocol DatabaseReference {
//
//}
class FirebaseManagerTests: XCTestCase {

    var manager: FirebaseManager!
    override func setUp() {
        super.setUp()
        let storage = Storage()
        let databaseReference = DatabaseReference()
        manager = FirebaseManager.init(storage: storage, databaseReference: databaseReference)
    }

    override func tearDown() {
        manager = nil
        super.tearDown()
    }

    func testExample() {
        manager.fetchAllImages { (model, error) in
            
        }
    }

}
