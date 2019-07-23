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

//    System under test
    var sut: ImageGalleryPresenter!
    override func setUp() {
        super.setUp()
        let viewController = ImageGalleryViewController()
        sut = ImageGalleryPresenter(viewController: viewController)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testExample() {
        let setRootExpectation: XCTestExpectation
    }
}
