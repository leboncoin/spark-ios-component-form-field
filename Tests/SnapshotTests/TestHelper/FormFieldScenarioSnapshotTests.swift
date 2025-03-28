//
//  FormFieldScenarioSnapshotTests.swift
//  SparkFormFieldSnapshotTests
//
//  Created by alican.aycil on 08.04.24.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import UIKit
@testable import SparkFormField
@_spi(SI_SPI) import SparkCommonSnapshotTesting

enum FormFieldScenarioSnapshotTests: String, CaseIterable {
    case test1
    case test2
    case test3
    case test4
    case test5
    case test6
    case test7

    // MARK: - Type Alias

    private typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Configurations

    func configuration() -> [FormFieldConfigurationSnapshotTests] {
        switch self {
        case .test1:
            return self.test1()
        case .test2:
            return self.test2()
        case .test3:
            return self.test3()
        case .test4:
            return self.test4()
        case .test5:
            return self.test5()
        case .test6:
            return self.test6()
        case .test7:
            return self.test7()
        }
    }

    // MARK: - Scenarios

    /// Test 1
    ///
    /// Description: To test all feedback states
    ///
    /// Content:
    ///  - feedbackState: all
    ///  - label: short
    ///  - helperMessage: short
    ///  - isCounter: false
    ///  - isRequired: false,
    ///  - isEnabled: true
    ///  - modes: light
    ///  - sizes (accessibility): default
    private func test1() -> [FormFieldConfigurationSnapshotTests] {
        let feedbackStates = FormFieldFeedbackState.allCases

        return feedbackStates.map { feedbackState in
                return .init(
                    scenario: self,
                    feedbackState: feedbackState,
                    label: "Agreement",
                    helperMessage: "Your agreement is important.",
                    isCounter: false,
                    isRequired: false,
                    isEnabled: true,
                    modes: Constants.Modes.default,
                    sizes: Constants.Sizes.default
                )
        }
    }

    /// Test 2
    ///
    /// Description: To test label's content resilience
    ///
    /// Content:
    ///  - feedbackState: 'default'
    ///  - label: all
    ///  - helperMessage: short
    ///  - isCounter: true
    ///  - isRequired: false,
    ///  - isEnabled: true
    ///  - modes: light
    ///  - sizes (accessibility): default
    private func test2() -> [FormFieldConfigurationSnapshotTests] {
        let labels: [String?] = [
            "Lorem Ipsum",
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            nil
        ]

        return labels.map { label in
            return .init(
                scenario: self,
                feedbackState: .default,
                label: label,
                helperMessage: "Your agreement is important.",
                isCounter: true,
                isRequired: false,
                isEnabled: true,
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.default
            )
        }
    }

    /// Test 3
    ///
    /// Description: To test required option
    ///
    /// Content:
    ///  - feedbackState: 'default'
    ///  - label: all
    ///  - helperMessage: short
    ///  - isCounter: false
    ///  - isRequired: false,
    ///  - isEnabled: true
    ///  - modes: light
    ///  - sizes (accessibility): default
    private func test3() -> [FormFieldConfigurationSnapshotTests] {
        return [.init(
            scenario: self,
            feedbackState: .default,
            label: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            helperMessage: "Your agreement is important.",
            isCounter: false,
            isRequired: true,
            isEnabled: true,
            modes: Constants.Modes.default,
            sizes: Constants.Sizes.default
        )]
    }

    /// Test 4
    ///
    /// Description: To test helper text's content resilience
    ///
    /// Content:
    ///  - feedbackState: error
    ///  - label: short
    ///  - helperMessage: all
    ///  - isCounter: true
    ///  - isRequired: false,
    ///  - isEnabled: true
    ///  - modes: light
    ///  - sizes (accessibility): default
    private func test4() -> [FormFieldConfigurationSnapshotTests] {
        let messages: [String?] = [
            "Lorem Ipsum",
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
            nil
        ]

        return messages.map { message in
            return .init(
                scenario: self,
                feedbackState: .error,
                label: "Agreement",
                helperMessage: message,
                isCounter: true,
                isRequired: false,
                isEnabled: true,
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.default
            )
        }
    }

    /// Test 5
    ///
    /// Description: To test disabled state
    ///
    /// Content:
    ///  - feedbackState: 'default'
    ///  - label: short
    ///  - helperMessage: short
    ///  - isCounter: false
    ///  - isRequired: false,
    ///  - isEnabled: true
    ///  - modes: light
    ///  - sizes (accessibility): default
    private func test5() -> [FormFieldConfigurationSnapshotTests] {
        let feedbackStates = FormFieldFeedbackState.allCases

        return feedbackStates.map { feedbackState in
            return .init(
                scenario: self,
                feedbackState: feedbackState,
                label: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                helperMessage: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
                isCounter: false,
                isRequired: false,
                isEnabled: false,
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.default
            )
        }
    }

    /// Test 6
    ///
    /// Description: To test dark & light mode
    ///
    /// Content:
    ///  - feedbackState: all
    ///  - label: short
    ///  - helperMessage: short
    ///  - isCounter: false
    ///  - isRequired: false,
    ///  - isEnabled: false
    ///  - modes: dark
    ///  - sizes (accessibility): default
    private func test6() -> [FormFieldConfigurationSnapshotTests] {
        let feedbackStates = FormFieldFeedbackState.allCases

        return feedbackStates.map { feedbackState in
            return .init(
                scenario: self,
                feedbackState: feedbackState,
                label: "Agreement",
                helperMessage: "Your agreement is important.",
                isCounter: false,
                isRequired: false,
                isEnabled: true,
                modes: [.dark],
                sizes: Constants.Sizes.default
            )
        }
    }

    /// Test 7
    ///
    /// Description: To test a11y sizes
    ///
    /// Content:
    ///  - feedbackState: error
    ///  - label: short
    ///  - helperMessage: short
    ///  - isCounter: false
    ///  - isRequired: false,
    ///  - isEnabled: false
    ///  - modes: light
    ///  - sizes (accessibility): all
    private func test7() -> [FormFieldConfigurationSnapshotTests] {

        return [.init(
            scenario: self,
            feedbackState: .error,
            label: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            helperMessage: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
            isCounter: false,
            isRequired: true,
            isEnabled: true,
            modes: Constants.Modes.default,
            sizes: Constants.Sizes.all
        )]
    }
}
