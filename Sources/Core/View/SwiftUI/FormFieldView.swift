//
//  FormFieldView.swift
//  SparkFormField
//
//  Created by alican.aycil on 18.03.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI
import SparkTheming

public struct FormFieldView<Component: View>: View {

    // MARK: - Properties

    @ObservedObject private var viewModel: FormFieldViewModel<AttributedString>
    @ScaledMetric private var spacing: CGFloat
    private let component: Component

    // MARK: - Initialization

    /// Initialize a formField.
    /// - Parameters:
    ///   - theme: The current Spark-Theme.
    ///   - component: The component is covered by formfield.
    ///   - feedbackState: The formfield feedback state. 'Default' or 'Error'.
    ///   - title: The formfield title.
    ///   - helper: The formfield helper message.
    ///   - isTitleRequired: The asterisk symbol at the end of title.
    public init(
        theme: Theme,
        @ViewBuilder component: @escaping () -> Component,
        feedbackState: FormFieldFeedbackState = .default,
        title: String? = nil,
        helper: String? = nil,
        isTitleRequired: Bool = false
    ) {
        let attributedTitle: AttributedString? = title.map(AttributedString.init)
        let attributedHelper: AttributedString? = helper.map(AttributedString.init)
        self.init(
            theme: theme,
            component: component,
            feedbackState: feedbackState,
            attributedTitle: attributedTitle,
            attributedHelper: attributedHelper,
            isTitleRequired: isTitleRequired
        )
    }

    /// Initialize a formField.
    /// - Parameters:
    ///   - theme: The current Spark-Theme.
    ///   - component: The component is covered by formfield.
    ///   - feedbackState: The formfield feedback state. 'Default' or 'Error'.
    ///   - title: The formfield title.
    ///   - description: The formfield helper message.
    ///   - isTitleRequired: The asterisk symbol at the end of title.
    @available(*, deprecated, message: "Replaced by the init with the helper String since the 0.1.1. (15/10/2024)")
    public init(
        theme: Theme,
        @ViewBuilder component: @escaping () -> Component,
        feedbackState: FormFieldFeedbackState = .default,
        title: String? = nil,
        description: String? = nil,
        isTitleRequired: Bool = false
    ) {
        self.init(
            theme: theme,
            component: component,
            feedbackState: feedbackState,
            title: title,
            helper: description,
            isTitleRequired: isTitleRequired
        )
    }

    /// Initialize a formField.
    /// - Parameters:
    ///   - theme: The current Spark-Theme.
    ///   - component: The component is covered by formfield.
    ///   - feedbackState: The formfield feedback state. 'Default' or 'Error'.
    ///   - attributedTitle: The formfield attributedTitle.
    ///   - attributedDescription: The formfield attributed helper message.
    ///   - isTitleRequired: The asterisk symbol at the end of title.
    public init(
        theme: Theme,
        @ViewBuilder component: @escaping () -> Component,
        feedbackState: FormFieldFeedbackState = .default,
        attributedTitle: AttributedString? = nil,
        attributedHelper: AttributedString? = nil,
        isTitleRequired: Bool = false
    ) {
        let viewModel = FormFieldViewModel<AttributedString>(
            theme: theme,
            feedbackState: feedbackState,
            title: attributedTitle,
            helper: attributedHelper,
            isTitleRequired: isTitleRequired
        )

        self.viewModel = viewModel
        self._spacing = ScaledMetric(wrappedValue: viewModel.spacing)
        self.component = component()
    }

    /// Initialize a formField.
    /// - Parameters:
    ///   - theme: The current Spark-Theme.
    ///   - component: The component is covered by formfield.
    ///   - feedbackState: The formfield feedback state. 'Default' or 'Error'.
    ///   - attributedTitle: The formfield attributedTitle.
    ///   - attributedDescription: The formfield attributed helper message.
    ///   - isTitleRequired: The asterisk symbol at the end of title.
    @available(*, deprecated, message: "Replaced by the init with the helper String since the 0.1.1. (15/10/2024)")
    public init(
        theme: Theme,
        @ViewBuilder component: @escaping () -> Component,
        feedbackState: FormFieldFeedbackState = .default,
        attributedTitle: AttributedString? = nil,
        attributedDescription: AttributedString? = nil,
        isTitleRequired: Bool = false
    ) {
        self.init(
            theme: theme,
            component: component,
            feedbackState: feedbackState,
            attributedTitle: attributedTitle,
            attributedHelper: attributedDescription,
            isTitleRequired: isTitleRequired
        )
    }

    // MARK: - View

    public var body: some View {
        VStack(alignment: .leading, spacing: self.spacing) {

            if let title = self.viewModel.title {
                Text(title)
                    .font(self.viewModel.titleFont.font)
                    .foregroundStyle(self.viewModel.titleColor.color)
                    .accessibilityIdentifier(FormFieldAccessibilityIdentifier.formFieldLabel)
            }
            self.component

            HStack(alignment: .top, spacing: self.spacing) {
                if let helper = self.viewModel.helper {
                    Text(helper)
                        .font(self.viewModel.helperFont.font)
                        .foregroundStyle(self.viewModel.helperColor.color)
                        .accessibilityIdentifier(FormFieldAccessibilityIdentifier.formFieldHelperMessage)
                }
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(FormFieldAccessibilityIdentifier.formField)
    }
}
