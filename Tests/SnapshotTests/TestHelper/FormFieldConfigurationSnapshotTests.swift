//
//  FormFieldConfigurationSnapshotTests.swift
//  SparkFormFieldSnapshotTests
//
//  Created by alican.aycil on 08.04.24.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import UIKit
@testable import SparkFormField
@_spi(SI_SPI) import SparkCommonSnapshotTesting

struct FormFieldConfigurationSnapshotTests {

    // MARK: - Properties

    let scenario: FormFieldScenarioSnapshotTests
    let feedbackState: FormFieldFeedbackState
    let title: String?
    let helper: String?
    let helperImageName: String?
    let isCounter: Bool
    let isRequired: Bool
    let isEnabled: Bool
    let modes: [ComponentSnapshotTestMode]
    let sizes: [UIContentSizeCategory]

    // MARK: - Getter

    func testName() -> String {
        return [
            "\(self.scenario.rawValue)",
            "\(self.feedbackState)" + "FeedbackState",
            self.title != nil ? "withTitle" : nil,
            self.helper != nil ? "withHelper" : nil,
            self.helperImageName != nil ? "withHelperImage" : nil,
            self.isRequired ? "isRequired" : nil,
            self.isEnabled ? "isEnabled" : nil,
            self.isCounter ? "isCounter" : nil
        ]
            .compactMap { $0 }
            .joined(separator: "-")
    }
}
