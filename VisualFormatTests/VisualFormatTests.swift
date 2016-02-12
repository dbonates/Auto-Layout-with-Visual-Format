//
//  VisualFormatTests.swift
//  VisualFormatTests
//
//  Created by Daniel Bonates on 2/11/16.
//  Copyright © 2016 Daniel Bonates. All rights reserved.
//

import XCTest
@testable import VisualFormat

class VisualFormatTests: XCTestCase {

    var vc:ViewController = ViewController()
    
    override func setUp() {
        super.setUp()
        
        vc = ViewController()
        vc.preloadView()
    
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewConstraintsShouldChangeHeightAsPaddingValueChanges() {
        
        let beforeHeight = vc.v1.bounds.height
        
        XCTAssertEqual(vc.v1.bounds.height, (vc.view.bounds.height-5*vc.pad)/4)
        
        vc.pad += 5
        vc.updateConstraints()
        
        XCTAssertEqual(vc.v1.bounds.height, (vc.view.bounds.height-5*vc.pad)/4)
        XCTAssertNotEqual(beforeHeight, vc.v1.bounds.height)
    }
    
    func testOnLoadShouldHaveFourViewsOfSameSize() {
        
        XCTAssertEqual(vc.v1.bounds.height, (vc.view.bounds.height-5*vc.pad)/4)
        
        let allHeights = [vc.v1.bounds.height,vc.v2.bounds.height,vc.v3.bounds.height,vc.v4.bounds.height]
        let uniqueHeights = NSCountedSet(array: allHeights)
        
        XCTAssertEqual(uniqueHeights.count, 1)
    }
    
    func testOnSwipeUpHeightShouldIncrease() {
        
        let beforeHeight = vc.v1.bounds.height
        
        let swipeGesture = UISwipeGestureRecognizer()
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Up
        
        vc.swiped(swipeGesture)
        
        XCTAssertTrue(beforeHeight < vc.v1.bounds.height)
        
    }
    
    func testOnSwipeDownHeightShouldDecrease() {
        
        let beforeHeight = vc.v1.bounds.height
        
        let swipeGesture = UISwipeGestureRecognizer()
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Down
        
        vc.swiped(swipeGesture)
        
        XCTAssertTrue(beforeHeight > vc.v1.bounds.height)
        
    }

}
