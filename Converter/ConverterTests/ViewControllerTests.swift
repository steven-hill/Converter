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
    
    func test_viewDidLoad_setsUpUnitTypeSegmentedControl() throws {
        let sut = try makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.unitType.numberOfSegments, 5, "There should be 5 segments.")
        XCTAssertEqual(sut.unitType.titleForSegment(at: 0), "Distance", "Segment at 0 should be 'Distance'.")
        XCTAssertEqual(sut.unitType.titleForSegment(at: 1), "Duration", "Segment at 1 should be 'Duration'.")
        XCTAssertEqual(sut.unitType.titleForSegment(at: 2), "Mass", "Segment at 2 should be 'Mass'.")
        XCTAssertEqual(sut.unitType.titleForSegment(at: 3), "Temperature", "Segment at 3 should be 'Temperature'.")
        XCTAssertEqual(sut.unitType.titleForSegment(at: 4), "Volume", "Segment at 4 should be 'Volume'.")
    }
    
    private func makeSUT() throws -> ViewController {
        let bundle = Bundle(for: ViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        let initialVC = sb.instantiateInitialViewController()
        return try XCTUnwrap(initialVC as? ViewController)
    }
}
