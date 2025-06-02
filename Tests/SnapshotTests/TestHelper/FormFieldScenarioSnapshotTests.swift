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
    case test8
    // case documentation

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
        case .test8:
            return self.test8()
        // case .documentation:
        //     return self.documentation()
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
    ///  - clearButton: nil
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
                clearButtonImageName: nil,
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
    ///  - clearButton: nil
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
                clearButtonImageName: nil,
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
    ///  - clearButton: nil
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
            clearButtonImageName: nil,
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
    ///  - clearButton: nil
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
            "It is a long established fact that a reader will be distracted.",
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
                        clearButtonImageName: nil,
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
    ///  - clearButton: nil
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
                clearButtonImageName: nil,
                helper: "It is a long established fact that a reader will be distracted.",
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
    /// Description: To test clear button
    ///
    /// Content:
    ///  - feedbackState: error
    ///  - title: all
    ///  - clearButton: visible
    ///  - helper: none
    ///  - helperImage: none
    ///  - isCounter: none
    ///  - isRequired: false,
    ///  - isEnabled: true
    ///  - modes: light
    ///  - sizes (accessibility): default
    private func test6() -> [FormFieldConfigurationSnapshotTests] {
        let titles: [String?] = [
            "Lorem Ipsum",
            "It is a long established fact that a reader will be distracted.",
            nil
        ]

        let imagesNames: [String?] = [
            "multiply.circle"
        ]

        return titles.flatMap { title in
            imagesNames.map { imageName in
                return .init(
                    scenario: self,
                    feedbackState: .error,
                    title: title,
                    clearButtonImageName: imageName,
                    helper: nil,
                    helperImageName: nil,
                    isCounter: false,
                    isRequired: false,
                    isEnabled: true,
                    modes: Constants.Modes.default,
                    sizes: Constants.Sizes.default
                )
            }
        }
    }

    /// Test 7
    ///
    /// Description: To test dark & light mode
    ///
    /// Content:
    ///  - feedbackState: all
    ///  - title: short
    ///  - clearButton: nil
    ///  - helper: short
    ///  - helperImage: nil
    ///  - isCounter: false
    ///  - isRequired: false,
    ///  - isEnabled: false
    ///  - modes: dark
    ///  - sizes (accessibility): default
    private func test7() -> [FormFieldConfigurationSnapshotTests] {
        let feedbackStates = FormFieldFeedbackState.allCases

        return feedbackStates.map { feedbackState in
            return .init(
                scenario: self,
                feedbackState: feedbackState,
                title: "Agreement",
                clearButtonImageName: nil,
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

    /// Test 8
    ///
    /// Description: To test a11y sizes
    ///
    /// Content:
    ///  - feedbackState: error
    ///  - title: short
    ///  - clearButton: all
    ///  - helper: short
    ///  - helperImage: true
    ///  - isCounter: all
    ///  - isRequired: false,
    ///  - isEnabled: false
    ///  - modes: light
    ///  - sizes (accessibility): all
    private func test8() -> [FormFieldConfigurationSnapshotTests] {
        let texts: [String?] = [
            "Lorem Ipsum",
            "It is a long established fact that a reader will be distracted.",
        ]

        let imageName = "multiply.circle"

        let isCounters: [Bool] = [true, false]

        return texts.flatMap { text in
            isCounters.map { isCounter in
                return .init(
                    scenario: self,
                    feedbackState: .error,
                    title: text,
                    clearButtonImageName: imageName,
                    helper: text,
                    helperImageName: imageName,
                    isCounter: isCounter,
                    isRequired: true,
                    isEnabled: true,
                    modes: Constants.Modes.default,
                    sizes: Constants.Sizes.all
                )
            }
        }
    }

    // MARK: - Documentation

    // Used to generate screenshot for Documentation
//    private func documentation() -> [FormFieldConfigurationSnapshotTests] {
//        let titles: [String?] = [
//            "Email (exemple@mail.fr)",
//            nil
//        ]
//
//        let clearButtons: [String?] = [
//            "multiply.circle",
//            nil
//        ]
//
//        let helpers: [String?] = [
//            "Please provide a valid email (exemple@mail.fr).",
//            nil
//        ]
//
//        let helperImageNames = [
//            "exclamationmark.circle",
//            nil
//        ]
//
//        let isCounters: [Bool] = [true, false]
//
//        return titles.flatMap { title in
//            clearButtons.flatMap { clearButton in
//                helpers.flatMap { helper in
//                    helperImageNames.flatMap { helperImageName in
//                        isCounters.map { isCounter in
//                            return .init(
//                                scenario: self,
//                                feedbackState: .default,
//                                title: title,
//                                clearButtonImageName: clearButton,
//                                helper: helper,
//                                helperImageName: helperImageName,
//                                isCounter: isCounter,
//                                isRequired: true,
//                                isEnabled: true,
//                                modes: Constants.Modes.all,
//                                sizes: Constants.Sizes.all
//                            )
//                        }
//                    }
//                }
//            }
//        }
//    }
}
