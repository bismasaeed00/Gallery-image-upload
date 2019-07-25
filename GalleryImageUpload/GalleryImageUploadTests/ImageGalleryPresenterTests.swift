//
//  ImageGalleryPresenterTests.swift
//  GalleryImageUploadTests
//
//  Created by Bisma Saeed on 21.07.19.
//  Copyright © 2019 Bisma Saeed. All rights reserved.
//

import XCTest
@testable import GalleryImageUpload

class ImageGalleryPresenterTests: XCTestCase {

    var presenter: ImageGalleryPresenter!
    override func setUp() {
        super.setUp()
        let viewController = ImageGalleryViewController()
        let firebaseManager = FirebaseManager.init()
        presenter = ImageGalleryPresenter(viewController: viewController, firebaseManager: firebaseManager)
    }

    override func tearDown() {
        presenter = nil
        super.tearDown()
    }

    func testImagePickerSetup() {
        XCTAssertNotNil(presenter.imagePicker)
    }
    
    func testImageGalleryViewControllerSetup() {
        XCTAssertNotNil(presenter.viewController)
    }
    
    func testFirebaseManagerSetup() {
        XCTAssertNotNil(presenter.firebaseManager)
    }
}
