//
//  FormFieldConstantsTests.swift
//  SparkFormField
//
//  Created by robin.lemaire on 07/05/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import XCTest
@testable import SparkFormField

final class FormFieldConstantsTests: XCTestCase {

    // MARK: - Tests

    func test_helperImageSize() {
        // GIVEN / WHEN / THEN
        XCTAssertEqual(
            FormFieldConstants.helperImageSize,
            18
        )
    }
}
