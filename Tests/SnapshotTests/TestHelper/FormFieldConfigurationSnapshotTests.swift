//
//  FormFieldConfigurationSnapshotTests.swift
//  SparkFormFieldSnapshotTests
//
//  Created by alican.aycil on 08.04.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
@testable import SparkFormField
@_spi(SI_SPI) import SparkCommonSnapshotTesting

struct FormFieldConfigurationSnapshotTests {

    // MARK: - Properties

    let scenario: FormFieldScenarioSnapshotTests
    let feedbackState: FormFieldFeedbackState
    let label: String?
    let helperMessage: String?
    let isCounter: Bool
    let isRequired: Bool
    let isEnabled: Bool
    let modes: [ComponentSnapshotTestMode]
    let sizes: [UIContentSizeCategory]

    // MARK: - Getter

    func testName() -> String {
        return [
            "\(self.scenario.rawValue)",
            "\(self.feedbackState)",
            "IsRequired:\(self.isRequired)",
            "IsEnabled:\(self.isEnabled)",
            "IsCounter:\(self.isCounter)"
        ].joined(separator: "-")
    }
}
