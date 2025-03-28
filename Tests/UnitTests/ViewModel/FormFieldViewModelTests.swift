//
//  FormFieldViewModelTests.swift
//  SparkFormFieldUnitTests
//
//  Created by alican.aycil on 26.03.24.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import Combine
import SwiftUI
import XCTest
@testable import SparkFormField
@_spi(SI_SPI) import SparkCommonTesting
@_spi(SI_SPI) import SparkThemingTesting

final class FormFieldViewModelTests: XCTestCase {

    var theme: ThemeGeneratedMock!
    var cancellable = Set<AnyCancellable>()
    var checkedImage = IconographyTests.shared.checkmark

    // MARK: - Setup
    override func setUpWithError() throws {
        try super.setUpWithError()

        self.theme = ThemeGeneratedMock.mocked()
    }

    // MARK: - Tests
    func test_init() throws {

        // Given
        let viewModel = FormFieldViewModel<NSAttributedString>(
            theme: self.theme,
            feedbackState: .default,
            title: NSAttributedString(string: "Title"),
            helper: NSAttributedString(string: "Helper"),
            isTitleRequired: true
        )

        // Then
        XCTAssertNotNil(viewModel.theme, "No theme set")
        XCTAssertNotNil(viewModel.feedbackState, "No feedback state set")
        XCTAssertNotNil(viewModel.isTitleRequired, "No title required set")
        XCTAssertTrue(viewModel.title?.string.contains("*") ?? false)
        XCTAssertEqual(viewModel.title?.string, "Title *")
        XCTAssertEqual(viewModel.helper?.string, "Helper")
        XCTAssertEqual(viewModel.spacing, self.theme.layout.spacing.small)
        XCTAssertEqual(viewModel.titleFont.uiFont, self.theme.typography.body2.uiFont)
        XCTAssertEqual(viewModel.helperFont.uiFont, self.theme.typography.caption.uiFont)
        XCTAssertEqual(viewModel.secondaryHelperFont.uiFont, self.theme.typography.caption.uiFont)
        XCTAssertEqual(viewModel.titleColor.uiColor, viewModel.colors.title.uiColor)
        XCTAssertEqual(viewModel.helperColor.uiColor, viewModel.colors.helper.uiColor)
        XCTAssertEqual(viewModel.secondaryHelperColor.uiColor, viewModel.colors.secondaryHelper.uiColor)
    }

    func test_texts_right_value() {
        // Given
        let viewModel = FormFieldViewModel<AttributedString>(
            theme: self.theme,
            feedbackState: .default,
            title: AttributedString("Title"),
            helper: AttributedString("Helper"),
            isTitleRequired: false
        )

        // Then
        XCTAssertEqual(viewModel.title, AttributedString("Title"))
        XCTAssertEqual(viewModel.helper, AttributedString("Helper"))
    }

    func test_isTitleRequired() async {
        // Given
        let viewModel = FormFieldViewModel<NSAttributedString>(
            theme: self.theme,
            feedbackState: .default,
            title: NSAttributedString("Title"),
            helper: NSAttributedString("Helper"),
            isTitleRequired: false
        )

        let expectation = expectation(description: "Title is updated")
        expectation.expectedFulfillmentCount = 2
        var isTitleUpdated = false

        viewModel.$title.sink(receiveValue: { title in
            isTitleUpdated = title?.string.contains("*") ?? false
            expectation.fulfill()
        })
        .store(in: &cancellable)

        // When
        viewModel.isTitleRequired = true

        await fulfillment(of: [expectation])

        // Then
        XCTAssertTrue(isTitleUpdated)
    }

    func test_set_title() {
        // Given
        let viewModel = FormFieldViewModel<NSAttributedString>(
            theme: self.theme,
            feedbackState: .default,
            title: NSAttributedString("Title"),
            helper: NSAttributedString("Helper"),
            isTitleRequired: true
        )

        // When
        viewModel.setTitle(NSAttributedString("Title2"))

        // Then
        XCTAssertEqual(viewModel.title?.string, "Title2 *")
    }

    func test_setCounter_with_text() {
        // Given
        let viewModel = FormFieldViewModel<NSAttributedString>(
            theme: self.theme,
            feedbackState: .default,
            title: NSAttributedString("Title"),
            helper: NSAttributedString("Helper"),
            isTitleRequired: true
        )

        // When
        viewModel.setCounter(text: "text", limit: 100)

        // Then
        XCTAssertEqual(viewModel.secondaryHelper, "4/100")
    }

    func test_setCounter_without_text() {
        // Given
        let viewModel = FormFieldViewModel<NSAttributedString>(
            theme: self.theme,
            feedbackState: .default,
            title: NSAttributedString("Title"),
            helper: NSAttributedString("Helper"),
            isTitleRequired: true
        )

        // When
        viewModel.setCounter(text: nil, limit: 100)

        // Then
        XCTAssertEqual(viewModel.secondaryHelper, "0/100")
    }

    func test_setCounter_with_textLength() {
        // Given
        let viewModel = FormFieldViewModel<NSAttributedString>(
            theme: self.theme,
            feedbackState: .default,
            title: NSAttributedString("Title"),
            helper: NSAttributedString("Helper"),
            isTitleRequired: true
        )

        // When
        viewModel.setCounter(textLength: 4, limit: 100)

        // Then
        XCTAssertEqual(viewModel.secondaryHelper, "4/100")
    }

    func test_setCounter_without_textLength() {
        // Given
        let viewModel = FormFieldViewModel<NSAttributedString>(
            theme: self.theme,
            feedbackState: .default,
            title: NSAttributedString("Title"),
            helper: NSAttributedString("Helper"),
            isTitleRequired: true
        )

        // When
        viewModel.setCounter(textLength: nil, limit: 100)

        // Then
        XCTAssertEqual(viewModel.secondaryHelper, "0/100")
    }

    func test_setCounter_without_limit() {
        // Given
        let viewModel = FormFieldViewModel<NSAttributedString>(
            theme: self.theme,
            feedbackState: .default,
            title: NSAttributedString("Title"),
            helper: NSAttributedString("Helper"),
            isTitleRequired: true
        )

        // When
        viewModel.setCounter(text: "azazd", limit: nil)

        // Then
        XCTAssertNil(viewModel.secondaryHelper)
    }

    func test_set_feedback_state() {
        // Given
        let viewModel = FormFieldViewModel<NSAttributedString>(
            theme: self.theme,
            feedbackState: .default,
            title: NSAttributedString("Title"),
            helper: NSAttributedString("Helper"),
            isTitleRequired: false
        )

        // When
        viewModel.feedbackState = .error

        // Then
        XCTAssertEqual(viewModel.feedbackState, .error)
    }
}
