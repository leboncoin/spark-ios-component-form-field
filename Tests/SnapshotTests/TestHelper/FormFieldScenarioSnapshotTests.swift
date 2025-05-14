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
    ///  - title: short
    ///  - helper: short
    ///  - helperImage: nil
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
                    title: "Agreement",
                    helper: "Your agreement is important.",
                    helperImageName: nil,
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
    /// Description: To test title's content resilience
    ///
    /// Content:
    ///  - feedbackState: 'default'
    ///  - title: all
    ///  - helper: short
    ///  - helperImage: nil
    ///  - isCounter: true
    ///  - isRequired: false,
    ///  - isEnabled: true
    ///  - modes: light
    ///  - sizes (accessibility): default
    private func test2() -> [FormFieldConfigurationSnapshotTests] {
        let titles: [String?] = [
            "Lorem Ipsum",
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            nil
        ]

        return titles.map { title in
            return .init(
                scenario: self,
                feedbackState: .default,
                title: title,
                helper: "Your agreement is important.",
                helperImageName: nil,
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
    ///  - title: all
    ///  - helper: short
    ///  - helperImage: nil
    ///  - isCounter: false
    ///  - isRequired: false,
    ///  - isEnabled: true
    ///  - modes: light
    ///  - sizes (accessibility): default
    private func test3() -> [FormFieldConfigurationSnapshotTests] {
        return [.init(
            scenario: self,
            feedbackState: .default,
            title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            helper: "Your agreement is important.",
            helperImageName: nil,
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
    ///  - title: short
    ///  - helper: all
    ///  - helperImage: all
    ///  - isCounter: all
    ///  - isRequired: false,
    ///  - isEnabled: true
    ///  - modes: light
    ///  - sizes (accessibility): default
    private func test4() -> [FormFieldConfigurationSnapshotTests] {
        let helpers: [String?] = [
            "Lorem Ipsum",
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
            nil
        ]

        let imagesNames: [String?] = [
            "infinity.circle",
            nil
        ]
        
        let isCounters: [Bool] = [true, false]

        return helpers.flatMap { helper in
            imagesNames.flatMap { imageName in
                isCounters.map { isCounter in
                    return .init(
                        scenario: self,
                        feedbackState: .error,
                        title: "Agreement",
                        helper: helper,
                        helperImageName: imageName,
                        isCounter: isCounter,
                        isRequired: false,
                        isEnabled: true,
                        modes: Constants.Modes.default,
                        sizes: Constants.Sizes.default
                    )
                }
            }
        }
    }

    /// Test 5
    ///
    /// Description: To test disabled state
    ///
    /// Content:
    ///  - feedbackState: 'default'
    ///  - title: short
    ///  - helper: short
    ///  - helperImage: true,
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
                title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                helper: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
                helperImageName: "infinity.circle",
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
    ///  - title: short
    ///  - helper: short
    ///  - helperImage: nil
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
                title: "Agreement",
                helper: "Your agreement is important.",
                helperImageName: nil,
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
    ///  - title: short
    ///  - helper: short
    ///  - helperImage: nil
    ///  - isCounter: false
    ///  - isRequired: false,
    ///  - isEnabled: false
    ///  - modes: light
    ///  - sizes (accessibility): all
    private func test7() -> [FormFieldConfigurationSnapshotTests] {

        return [.init(
            scenario: self,
            feedbackState: .error,
            title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            helper: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
            helperImageName: nil,
            isCounter: false,
            isRequired: true,
            isEnabled: true,
            modes: Constants.Modes.default,
            sizes: Constants.Sizes.all
        )]
    }
}
