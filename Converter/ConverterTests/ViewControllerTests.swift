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
        let _ = try XCTUnwrap(initialVC)
    }
}
