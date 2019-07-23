//
//  ImagePickerTests.swift
//  GalleryImageUploadTests
//
//  Created by Bisma Saeed on 23.07.19.
//  Copyright © 2019 Bisma Saeed. All rights reserved.
//

import XCTest
@testable import GalleryImageUpload
class ImagePickerDelegateTest: ImagePickerDelegate {
    var asyncExpectation: XCTestExpectation?
    var responseImage: UIImage?
    
    func didSelect(image: UIImage?) {
        guard let expectation = asyncExpectation else {
            XCTFail("Image picker delegate did not setup correctly")
            return
        }
        responseImage = image
        expectation.fulfill()
    }
}

class ImagePickerTests: XCTestCase {

    var imagePicker: ImagePicker!
    var delegate: ImagePickerDelegateTest? = ImagePickerDelegateTest()
    var viewController: UIViewController? = UIViewController()
    
    override func setUp() {
        super.setUp()
        
        imagePicker = ImagePicker.init(presentationController: UIViewController(), delegate: delegate!)
        
    }

    override func tearDown() {
        imagePicker = nil
        delegate = nil
        viewController = nil
        super.tearDown()
    }

    func testImagePickePresent() {
        XCTAssertNotNil(viewController?.view)
        let expectation = self.expectation(description: "ImapePickerAlert")
        imagePicker.present(from: viewController!.view)
        expectation.fulfill()
        
        // Wait for the expectation to be fullfilled, or time out
        // after 5 seconds. This is where the test runner will pause.
        waitForExpectations(timeout: 2) { error in
            
        }
        
//        if var topController = UIApplication.shared.keyWindow?.rootViewController {
//            while let presentedViewController = topController.presentedViewController {
//                topController = presentedViewController
//            }
//            XCTAssertTrue(topController is UIAlertController)
//        }
    }

}
