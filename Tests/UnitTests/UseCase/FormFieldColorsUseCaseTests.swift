//
//  FormFieldColorsUseCaseTests.swift
//  SparkFormField
//
//  Created by alican.aycil on 26.03.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkFormField
@_spi(SI_SPI) import SparkThemingTesting

final class FormFieldColorsUseCaseTests: XCTestCase {

    var sut: FormFieldColorsUseCase!
    var theme: ThemeGeneratedMock!

    override func setUp() {
        super.setUp()

        self.sut = .init()
        self.theme = .mocked()
    }

    // MARK: - Tests

    func test_execute_for_all_feedback_cases() {
        let feedbacks = FormFieldFeedbackState.allCases

        feedbacks.forEach {

            let formfieldColors = sut.execute(from: theme, feedback: $0)

            let expectedFormFieldColor: FormFieldColors
            let expectedCommonColor = self.theme.colors.base.onSurface.opacity(theme.dims.dim1)

            switch $0 {
            case .default:
                expectedFormFieldColor = FormFieldColors(
                    title: theme.colors.base.onSurface,
                    helper: expectedCommonColor,
                    asterisk: expectedCommonColor,
                    info: expectedCommonColor
                )
            case .error:
                expectedFormFieldColor = FormFieldColors(
                    title: theme.colors.base.onSurface,
                    helper: theme.colors.feedback.error,
                    asterisk: expectedCommonColor,
                    info: expectedCommonColor
                )
            }

            XCTAssertEqual(formfieldColors.title.uiColor, expectedFormFieldColor.title.uiColor)
            XCTAssertEqual(formfieldColors.helper.uiColor, expectedFormFieldColor.helper.uiColor)
            XCTAssertEqual(formfieldColors.asterisk.uiColor, expectedFormFieldColor.asterisk.uiColor)
            XCTAssertEqual(formfieldColors.info.uiColor, expectedFormFieldColor.info.uiColor)
        }
    }
}
