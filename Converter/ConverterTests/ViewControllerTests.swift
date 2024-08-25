//
//  ViewControllerTests.swift
//  ConverterTests
//
//  Created by Steven Hill on 24/08/2024.
//

import XCTest
@testable import Converter

final class ViewControllerTests: XCTestCase {

    func test_viewController_canInit() throws {
        let bundle = Bundle(for: ViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        let initialVC = sb.instantiateInitialViewController()
        _ = try XCTUnwrap(initialVC as? ViewController)
    }
    
    func test_viewController_isDelegateAndDataSourceOfTableViews() throws {
        let bundle = Bundle(for: ViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        let initialVC = sb.instantiateInitialViewController()
        let sut = try XCTUnwrap(initialVC as? ViewController)
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.fromUnit.dataSource, "VC should be fromUnit tableView's data source.")
        XCTAssertNotNil(sut.fromUnit.delegate, "VC should be fromUnit tableView's delegate.")
        XCTAssertNotNil(sut.toUnit.dataSource, "VC should be toUnit tableView's data source.")
        XCTAssertNotNil(sut.toUnit.delegate, "VC should be toUnit tableView's delegate.")
    }
}
