//
//  ImageGalleryViewController.swift
//  GalleryImageUploadTests
//
//  Created by Bisma Saeed on 23.07.19.
//  Copyright © 2019 Bisma Saeed. All rights reserved.
//

import XCTest
@testable import GalleryImageUpload

class ImageGalleryViewControllerTests: XCTestCase {

    var viewController: ImageGalleryViewController!
    var navigationController: UINavigationController!
    
    override func setUp() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        navigationController = storyboard.instantiateInitialViewController() as? UINavigationController
        viewController = navigationController.topViewController as? ImageGalleryViewController
        UIApplication.shared.keyWindow!.rootViewController = viewController
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    // if storyboard name is not correct, tests should fail.
    // if navigation controller is not at the root, test should fail.
    // if view controller does not exists in the storyboard, test should fail
    
    func testLoadingViewController() {
        XCTAssertNotNil(viewController?.view, "ImageGalleryController is nil")
    }
    
    func testNavigationControllerPresence() {
        XCTAssertNotNil(navigationController.view, "Navigationcontroller at storyboard entry is nil")
    }
    
    // if collection view is linked with the outlet
    func testCollectionViewLinked() {
        XCTAssertNotNil(viewController.galleryCollectionView, "gallerycollectionview outlet is nil")
    }
}
