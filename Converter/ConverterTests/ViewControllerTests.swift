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
        _ = try makeSUT()
    }
    
    func test_viewController_isDelegateAndDataSourceOfTableViews() throws {
        let sut = try makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.fromUnit.dataSource, "VC should be fromUnit tableView's data source.")
        XCTAssertNotNil(sut.fromUnit.delegate, "VC should be fromUnit tableView's delegate.")
        XCTAssertNotNil(sut.toUnit.dataSource, "VC should be toUnit tableView's data source.")
        XCTAssertNotNil(sut.toUnit.delegate, "VC should be toUnit tableView's delegate.")
    }
    
    private func makeSUT() throws -> ViewController {
        let bundle = Bundle(for: ViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        let initialVC = sb.instantiateInitialViewController()
        return try XCTUnwrap(initialVC as? ViewController)
    }
}
