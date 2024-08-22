// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// swiftlint:disable all
let package = Package(
    name: "SparkFormField",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "SparkFormField",
            targets: ["SparkFormField"]
        ),
        .library(
            name: "SparkFormFieldTesting",
            targets: ["SparkFormFieldTesting"]
        )
    ],
    dependencies: [
       .package(
           url: "https://github.com/adevinta/spark-ios-common.git",
           // path: "../spark-ios-common"
           /*version*/ "0.0.1"..."999.999.999"
       ),
       .package(
           url: "https://github.com/adevinta/spark-ios-theming.git",
           // path: "../spark-ios-theming"
           /*version*/ "0.0.1"..."999.999.999"
       ),
       .package(
           url: "https://github.com/adevinta/spark-ios-component-checkbox.git",
           // path: "../spark-ios-component-checkbox"
           /*version*/ "0.0.1"..."999.999.999"
       ),
       .package(
           url: "https://github.com/adevinta/spark-ios-component-radio-button.git",
           // path: "../spark-ios-component-radio-button"
           /*version*/ "0.0.1"..."999.999.999"
       )
    ],
    targets: [
        .target(
            name: "SparkFormField",
            dependencies: [
                .product(
                    name: "SparkCommon",
                    package: "spark-ios-common"
                ),
                .product(
                    name: "SparkTheming",
                    package: "spark-ios-theming"
                )
            ],
            path: "Sources/Core"
        ),
        .target(
            name: "SparkFormFieldTesting",
            dependencies: [
                "SparkFormField",
                .product(
                    name: "SparkCommon",
                    package: "spark-ios-common"
                ),
                .product(
                    name: "SparkCommonTesting",
                    package: "spark-ios-common"
                ),
                .product(
                    name: "SparkThemingTesting",
                    package: "spark-ios-theming"
                ),
                .product(
                    name: "SparkTheme",
                    package: "spark-ios-theming"
                )
            ],
            path: "Sources/Testing"
        ),
        .testTarget(
            name: "SparkFormFieldUnitTests",
            dependencies: [
                "SparkFormField",
                "SparkFormFieldTesting",
                .product(
                    name: "SparkCommonTesting",
                    package: "spark-ios-common"
                ),
                .product(
                    name: "SparkThemingTesting",
                    package: "spark-ios-theming"
                )
            ],
            path: "Tests/UnitTests"
        ),
        .testTarget(
            name: "SparkFormFieldSnapshotTests",
            dependencies: [
                "SparkFormField",
                "SparkFormFieldTesting",
                .product(
                    name: "SparkCommonSnapshotTesting",
                    package: "spark-ios-common"
                ),
                .product(
                    name: "SparkCheckbox",
                    package: "spark-ios-component-checkbox"
                ),
                .product(
                    name: "SparkRadioButton",
                    package: "spark-ios-component-radio-button"
                ),
            ],
            path: "Tests/SnapshotTests"
        ),
    ]
)
