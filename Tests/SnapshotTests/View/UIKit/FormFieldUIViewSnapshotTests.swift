//
//  FormFieldUIViewSnapshotTests.swift
//  SparkFormFieldSnapshotTests
//
//  Created by robin.lemaire on 06/05/25.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import UIKit
@testable import SparkFormField
@_spi(SI_SPI) import SparkCommonSnapshotTesting
@_spi(SI_SPI) import SparkCommon
@_spi(SI_SPI) import SparkCommonTesting
import SparkTheming
@_spi(SI_SPI) import SparkThemingTesting
import SparkTheme

final class FormFieldUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Type Alias

    private typealias Constants = FormFieldSnapshotConstants

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() {
        let scenarios = FormFieldScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations = scenario.configuration()

            for configuration in configurations {

                let component = UITextField()
                component.borderStyle = .roundedRect
                component.text = "Your username"

                let view = FormFieldUIView(
                    theme: self.theme,
                    component: component,
                    feedbackState: configuration.feedbackState,
                    title: configuration.label,
                    helper: configuration.helperMessage,
                    isRequired: configuration.isRequired
                )

                if configuration.isCounter {
                    view.setCounter(on: "Text", limit: 100)
                }

                view.backgroundColor = .systemBackground

                let backgroundView = UIView()
                backgroundView.backgroundColor = .secondarySystemBackground
                backgroundView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    backgroundView.widthAnchor.constraint(equalToConstant: Constants.maxWidth)
                ])
                backgroundView.addSubview(view)
                NSLayoutConstraint.stickEdges(
                    from: view,
                    to: backgroundView,
                    insets: .init(all: Constants.padding)
                )

                self.assertSnapshot(
                    matching: backgroundView,
                    modes: configuration.modes,
                    sizes: configuration.sizes,
                    testName: configuration.testName()
                )
            }
        }
    }
}

private extension UIImage {
    static let mock: UIImage = UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
}
