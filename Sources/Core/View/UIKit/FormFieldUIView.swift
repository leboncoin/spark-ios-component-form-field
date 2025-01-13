//
//  FormFieldUIView.swift
//  SparkFormField
//
//  Created by alican.aycil on 30.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import SwiftUI
import UIKit
@_spi(SI_SPI) import SparkCommon
import SparkTheming
import SparkTextInput

// TODO: compression resistance

/// The `FormFieldUIView`renders a component with title and subtitle using UIKit.
public final class FormFieldUIView<Component: UIView>: UIView {

    // MARK: - Components

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel, self.bottomStackView])
        stackView.axis = .vertical
        stackView.spacing = self.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityUserInputLabels
        return stackView
    }()

    /// The title label of the input. The label is positioned at the top left.
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = FormFieldAccessibilityIdentifier.formFieldLabel
        label.isAccessibilityElement = true
        return label
    }()

    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.helperLabel, self.secondaryHelperLabel])
        stackView.axis = .horizontal
        stackView.spacing = self.spacing
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    /// The helper label of the input. The label is positioned at the bottom left.
    public let helperLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.isHidden = true
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = FormFieldAccessibilityIdentifier.formFieldHelperMessage
        label.isAccessibilityElement = true
        return label
    }()

    @available(*, deprecated, message: "Replaced by helperLabel since the 0.1.1.")
    public var descriptionLabel: UILabel {
        self.helperLabel
    }

    /// The secondary helper label of the input. The label is positioned at the bottom right.
    /// Note : The label has a default *horizontal compression resistance priority* at **.required**.
    public let secondaryHelperLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.backgroundColor = .clear
        label.adjustsFontForContentSizeCategory = true
        label.isHidden = true
        label.accessibilityIdentifier = FormFieldAccessibilityIdentifier.formFieldSecondaryHelperMessage
        label.isAccessibilityElement = true
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()

    // MARK: - Public properties.

    /// The title of formfield.
    public var title: String? {
        get {
            return self.titleLabel.text
        }
        set {
            self.viewModel.setTitle(newValue.map(NSAttributedString.init))
        }
    }

    /// The attributedTitle of formfield.
    public var attributedTitle: NSAttributedString? {
        get {
            return self.titleLabel.attributedText
        }
        set {
            self.viewModel.setTitle(newValue)
        }
    }

    public var isTitleRequired: Bool {
        get {
            return self.viewModel.isTitleRequired
        }
        set {
            self.viewModel.isTitleRequired = newValue
        }
    }

    /// The helper of formfield.
    public var helperString: String? {
        get {
            return self.helperLabel.text
        }
        set {
            self.viewModel.helper = newValue.map(NSAttributedString.init)
        }
    }

    /// The description of formfield.
    @available(*, deprecated, message: "Replaced by helperString since the 0.1.1.")
    public var descriptionString: String? {
        get {
            return self.helperString
        }
        set {
            self.helperString = newValue
        }
    }

    /// The helper attributedHelper of formfield.
    public var attributedHelper: NSAttributedString? {
        get {
            return self.helperLabel.attributedText
        }
        set {
            self.viewModel.helper = newValue
        }
    }

    /// The attributedDescription of formfield.
    @available(*, deprecated, message: "Replaced by attributedHelper since the 0.1.1.")
    public var attributedDescription: NSAttributedString? {
        get {
            return self.attributedHelper
        }
        set {
            self.attributedHelper = newValue
        }
    }

    /// Returns the theme of the formfield.
    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
        }
    }

    /// Returns the theme of the formfield.
    public var feedbackState: FormFieldFeedbackState {
        get {
            return self.viewModel.feedbackState
        }
        set {
            self.viewModel.feedbackState = newValue
        }
    }

    /// The component of formfield.
    public var component: Component {
        didSet {
            oldValue.removeFromSuperview()
            self.setComponent()
        }
    }

    var viewModel: FormFieldViewModel<NSAttributedString>

    private var cancellables = Set<AnyCancellable>()
    @ScaledUIMetric private var spacing: CGFloat

    // MARK: - Initialization

    /// Not implemented. Please use another init.
    /// - Parameter coder: the coder.
    public required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

    /// Initialize a formField.
    /// - Parameters:
    ///   - theme: The current Spark-Theme.
    ///   - component: The component is covered by formfield.
    ///   - feedbackState: The formfield feedback state. 'Default' or 'Error'.
    ///   - title: The formfield title.
    ///   - helper: The formfield helper message.
    ///   - isTitleRequired: The asterisk symbol at the end of title.
    public convenience init(
        theme: Theme,
        component: Component,
        feedbackState: FormFieldFeedbackState = .default,
        title: String? = nil,
        helper: String? = nil,
        isTitleRequired: Bool = false
    ) {
        let attributedTitle: NSAttributedString? = title.map(NSAttributedString.init)
        let attributedHelper: NSAttributedString? = helper.map(NSAttributedString.init)
        self.init(
            theme: theme,
            component: component,
            feedbackState: feedbackState,
            attributedTitle: attributedTitle,
            attributedHelper: attributedHelper,
            isTitleRequired: isTitleRequired
        )
    }

    // TODO: depercated and helper
    /// Initialize a formField.
    /// - Parameters:
    ///   - theme: The current Spark-Theme.
    ///   - component: The component is covered by formfield.
    ///   - feedbackState: The formfield feedback state. 'Default' or 'Error'.
    ///   - title: The formfield title.
    ///   - description: The formfield helper message.
    ///   - isTitleRequired: The asterisk symbol at the end of title.
    @available(*, deprecated, message: "Replaced by the init with the helper String since the 0.1.1.")
    public convenience init(
        theme: Theme,
        component: Component,
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
        component: Component,
        feedbackState: FormFieldFeedbackState = .default,
        attributedTitle: NSAttributedString? = nil,
        attributedHelper: NSAttributedString? = nil,
        isTitleRequired: Bool = false
    ) {
        let viewModel = FormFieldViewModel<NSAttributedString>(
            theme: theme,
            feedbackState: feedbackState,
            title: attributedTitle,
            helper: attributedHelper,
            isTitleRequired: isTitleRequired
        )

        self.viewModel = viewModel
        self.spacing = viewModel.spacing
        self.component = component

        super.init(frame: .zero)

        self.setupViews()
        self.setComponent()
        self.subscribe()
        self.updateAccessibility()
    }

    /// Initialize a formField.
    /// - Parameters:
    ///   - theme: The current Spark-Theme.
    ///   - component: The component is covered by formfield.
    ///   - feedbackState: The formfield feedback state. 'Default' or 'Error'.
    ///   - attributedTitle: The formfield attributedTitle.
    ///   - attributedDescription: The formfield attributed helper message.
    ///   - isTitleRequired: The asterisk symbol at the end of title.
    @available(*, deprecated, message: "Replaced by the init with the helper String since the 0.1.1.")
    public convenience init(
        theme: Theme,
        component: Component,
        feedbackState: FormFieldFeedbackState = .default,
        attributedTitle: NSAttributedString? = nil,
        attributedDescription: NSAttributedString? = nil,
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

    // MARK: - Setup

    private func updateAccessibility() {
        self.accessibilityIdentifier = FormFieldAccessibilityIdentifier.formField
        self.isAccessibilityElement = false
        self.accessibilityContainerType = .semanticGroup
    }

    private func setComponent() {
        self.stackView.insertArrangedSubview(self.component, at: 1)
    }

    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.stackView)
        NSLayoutConstraint.stickEdges(from: self.stackView, to: self)
    }

    // MARK: - Subscription

    private func subscribe() {
        // ***
        // Title
        self.viewModel.$title.subscribe(in: &self.cancellables) { [weak self] text in
            self?.titleLabel.isHidden = text == nil
            self?.titleLabel.attributedText = text
        }

        self.viewModel.$titleFont.subscribe(in: &self.cancellables) { [weak self] font in
            self?.titleLabel.font = font.uiFont
        }

        self.viewModel.$titleColor.subscribe(in: &self.cancellables) { [weak self] color in
            self?.titleLabel.textColor = color.uiColor
        }
        // ***

        // ***
        // Helper
        self.viewModel.$helper.subscribe(in: &self.cancellables) { [weak self] text in
            self?.helperLabel.isHidden = text == nil
            self?.helperLabel.attributedText = text
        }

        self.viewModel.$helperFont.subscribe(in: &self.cancellables) { [weak self] font in
            self?.helperLabel.font = font.uiFont
        }

        self.viewModel.$helperColor.subscribe(in: &self.cancellables) { [weak self] color in
            self?.helperLabel.textColor = color.uiColor
        }
        // ***

        // ***
        // Seconday Helper
        self.viewModel.$secondaryHelper.subscribe(in: &self.cancellables) { [weak self] text in
            self?.secondaryHelperLabel.isHidden = text == nil
            self?.secondaryHelperLabel.text = text
        }

        self.viewModel.$secondaryHelperFont.subscribe(in: &self.cancellables) { [weak self] font in
            self?.secondaryHelperLabel.font = font.uiFont
        }

        self.viewModel.$secondaryHelperColor.subscribe(in: &self.cancellables) { [weak self] color in
            self?.secondaryHelperLabel.textColor = color.uiColor
        }
        // ***

        self.viewModel.$spacing.subscribe(in: &self.cancellables) { [weak self] spacing in
            guard let self = self else { return }
            self._spacing.wrappedValue = spacing
            self.stackView.spacing = self.spacing
        }
    }

    // MARK: - Trait Collection

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory else { return }

        self._spacing.update(traitCollection: traitCollection)
        self.stackView.spacing = self.spacing
    }
}

// MARK: - Public Extension

public extension FormFieldUIView where Component: UITextInput {

    // MARK: - Public Setter

    /// Display a counter value (X/Y) in the secondary helper label with a text and the limit.
    /// - parameter text: the text where the characters must be counted.
    /// - parameter limit: the counter limit. If the value is nil, the counter is not displayed.
    func setCounter(on text: String?, limit: Int?) {
        self.viewModel.setCounter(textLength: text?.count, limit: limit)
    }

    /// Display a counter value (X/Y) in the secondary helper label with a text length and the limit.
    /// - parameter textLength: the text length.
    /// - parameter limit: the counter limit. If the value is nil, the counter is not displayed.
    func setCounter(on textLength: Int, limit: Int?) {
        self.viewModel.setCounter(textLength: textLength, limit: limit)
    }
}

public extension FormFieldUIView where Component: TextFieldAddonsUIView {

    // MARK: - Public Setter

    /// Display a counter value (X/Y) in the secondary helper label with a text and the limit.
    /// - parameter text: the text where the characters must be counted.
    /// - parameter limit: the counter limit. If the value is nil, the counter is not displayed.
    func setCounter(on text: String?, limit: Int?) {
        self.viewModel.setCounter(textLength: text?.count, limit: limit)
    }

    /// Display a counter value (X/Y) in the secondary helper label with a text length and the limit.
    /// - parameter textLength: the text length.
    /// - parameter limit: the counter limit. If the value is nil, the counter is not displayed.
    func setCounter(on textLength: Int, limit: Int?) {
        self.viewModel.setCounter(textLength: textLength, limit: limit)
    }
}
