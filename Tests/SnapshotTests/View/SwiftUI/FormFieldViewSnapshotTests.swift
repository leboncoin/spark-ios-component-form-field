//
//  FormFieldViewSnapshotTests.swift
//  SparkFormFieldSnapshotTests
//
//  Created by alican.aycil on 14.04.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI
@testable import SparkFormField
@_spi(SI_SPI) import SparkCommonSnapshotTesting
import SparkTheming
@_spi(SI_SPI) import SparkThemingTesting
import SparkTheme

final class FormFieldViewSnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() {
        let scenarios = FormFieldScenarioSnapshotTests.allCases

        var _isOn: Bool = true
        lazy var isOn: Binding<Bool> = {
            return Binding<Bool>(
                get: { return _isOn },
                set: { newValue in
                    _isOn = newValue
                }
            )
        }()

        for scenario in scenarios {
            let configurations = scenario.configuration()

            for configuration in configurations {

                let component = HStack {
                    Toggle("", isOn: isOn)
                        .labelsHidden()
                    Spacer()
                }

                let view = FormFieldView(
                    theme: self.theme,
                    component: {
                        component
                    },
                    feedbackState: configuration.feedbackState,
                    title: configuration.label,
                    description: configuration.helperMessage,
                    isTitleRequired: configuration.isRequired
                )
                .frame(width: 300)
                .fixedSize(horizontal: false, vertical: true)
                .disabled(!configuration.isEnabled)
                .background(Color(.systemBackground))

                self.assertSnapshot(
                    matching: view,
                    modes: configuration.modes,
                    sizes: configuration.sizes,
                    testName: configuration.testName()
                )
            }
        }
    }
}
