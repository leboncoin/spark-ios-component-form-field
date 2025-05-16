//
//  FormFieldView.swift
//  SparkFormField
//
//  Created by alican.aycil on 18.03.24.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming
@_spi(SI_SPI) import SparkCommon

/// The **Spark** FormField provide context to your form elements easily.
///
/// FormField provide context to your form elements easily,
/// unifying an a proper way to show a label, required marker,
/// help & status messages or counter in any input/field components.
///
/// Implementation example :
/// ```swift
/// struct MyView: View {
///     let theme: SparkTheming.Theme = MyTheme()
///     @State var text: String = ""
///
///     var body: some View {
///         FormFieldView(
///             theme: self.theme,
///             feedbackState: .default,
///             title: "Email (exemple@mail.fr)",
///             helper: "Please provide a valid email (exemple@mail.fr).",
///             helperImage: Image(systemName: "exclamationmark.circle"),
///             isRequired: true,
///             component: {
///                 TextField("Email (exemple@mail.fr)", text: self.$text)
///             }
///         )
///     }
/// }
/// ```
///
/// ![FormField rendering with TextField.](component.png)
public struct FormFieldView<Component: View>: View {

    // MARK: - Properties

    @ObservedObject private var viewModel: FormFieldViewModel
    @ScaledMetric private var spacing: CGFloat

    private var clearButton: ClearButton?
    private let helperImage: Image?
    private let component: Component

    @ScaledMetric private var iconSize = FormFieldConstants.iconSize
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @AccessibilityFocusState private var isComponentFocused: Bool

    @State private var titleAccessibility: Accessibility = .init()
    private var clearButtonAccessibility: Accessibility = .init()
    private var helperAccessibility: Accessibility = .init()
    private var secondaryHelperAccessibility: Accessibility = .init()

    // MARK: - Initialization

    /// Initialize a formField.
    /// - Parameters:
    ///   - theme: The current Spark-Theme.
    ///   - feedbackState: The formfield feedback state. 'Default' or 'Error'.
    ///   - title: The formfield title.
    ///   - helper: The formfield helper message.
    ///   - helperImage: The helper image displayed to the left of the helper text. **Displayed only if helper is setted**.
    ///   - isRequired: Add an asterisk symbol at the end of title if the value is true.
    ///   - component: The component is covered by formfield.
    ///
    /// Implementation example :
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///     @State var text: String = ""
    ///
    ///     var body: some View {
    ///         FormFieldView(
    ///             theme: self.theme,
    ///             feedbackState: .default,
    ///             title: "Email (exemple@mail.fr)",
    ///             helper: "Please provide a valid email (exemple@mail.fr).",
    ///             helperImage: Image(systemName: "exclamationmark.circle"),
    ///             isRequired: true,
    ///             component: {
    ///                 TextField("Email (exemple@mail.fr)", text: self.$text)
    ///             }
    ///         )
    ///     }
    /// }
    /// ```
    ///
    /// ![FormField rendering with TextField.](component.png)
    public init(
        theme: Theme,
        feedbackState: FormFieldFeedbackState = .default,
        title: String? = nil,
        helper: String? = nil,
        helperImage: Image? = nil,
        isRequired: Bool = false,
        @ViewBuilder component: @escaping () -> Component
    ) {

        let viewModel = FormFieldViewModel(
            frameworkType: .swiftUI,
            theme: theme,
            feedbackState: feedbackState,
            title: title,
            helper: helper,
            isRequired: isRequired
        )

        self.viewModel = viewModel
        self._spacing = ScaledMetric(wrappedValue: viewModel.spacing)
        self._spacing = ScaledMetric(wrappedValue: viewModel.spacing)

        self.helperImage = helperImage
        self.component = component()

        self.titleAccessibility.label = viewModel.titleAccessibilityLabel
    }

    /// Initialize a formField.
    /// - Parameters:
    ///   - theme: The current Spark-Theme.
    ///   - component: The component is covered by formfield.
    ///   - feedbackState: The formfield feedback state. 'Default' or 'Error'.
    ///   - title: The formfield title.
    ///   - helper: The formfield helper message.
    ///   - isTitleRequired: The asterisk symbol at the end of title.
    @available(*, deprecated, message: "Replaced by the init with the isRequired String since the 1.1.0.")
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
    @available(*, deprecated, message: "Replaced by the init with the helper String since the 0.1.1.")
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
    ///   - attributedHelper: The formfield attributed helper message.
    ///   - isTitleRequired: The asterisk symbol at the end of title.
    @available(*, deprecated, message: "Replaced by the init with the title and helper String since the 1.1.0.")
    public init(
        theme: Theme,
        @ViewBuilder component: @escaping () -> Component,
        feedbackState: FormFieldFeedbackState = .default,
        attributedTitle: AttributedString? = nil,
        attributedHelper: AttributedString? = nil,
        isTitleRequired: Bool = false
    ) {
        let title: String? = if let attributedTitle {
            .init(attributedTitle.characters)
        } else {
            nil
        }

        let helper: String? = if let attributedHelper {
            .init(attributedHelper.characters)
        } else {
            nil
        }

        self.init(
            theme: theme,
            component: component,
            feedbackState: feedbackState,
            title: title,
            helper: helper,
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
    @available(*, deprecated, message: "Replaced by the init with the helper String since the 0.1.1.")
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
            let isAccessibilityStack = self.dynamicTypeSize.isAccessibilitySize && self.horizontalSizeClass == .compact

            // Header
            if self.viewModel.formattedTitle != nil || self.clearButton != nil {
                AdaptiveStack(
                    axis: .horizontal,
                    alignment: .bottom,
                    spacing: self.spacing,
                    accessibilityAlignment: .trailing,
                    showAccessibilityStack: isAccessibilityStack
                ) {
                    // Title
                    if let formattedTitle = self.viewModel.formattedTitle?.rightValue {
                        Text(formattedTitle)
                            .titleFrame(isAccessibilityStack: isAccessibilityStack)
                            .accessibilityIdentifier(FormFieldAccessibilityIdentifier.formFieldTitle)
                            .accessibilitySortPriority(5)
                            .accessibility(self.titleAccessibility)
                    }

                    OptionalHStack(onStack: isAccessibilityStack) {
                        Spacer(minLength: 0)

                        // Clear Button
                        if let clearButton {
                            clearButton
                                .font(self.viewModel.clearButtonFont)
                                .foregroundStyle(self.viewModel.clearButtonColor)
                                .spacing(self.spacing)
                                .accessibilityIdentifier(FormFieldAccessibilityIdentifier.formFieldClearButton)
                                .accessibilitySortPriority(4)
                                .accessibility(self.clearButtonAccessibility)
                                .layoutPriority(3)
                        }
                    }
                }
            }

            // Component
            self.component
                .accessibilityFocused(self.$isComponentFocused)
                .accessibilitySortPriority(3)

            // Footer
            if self.viewModel.helper != nil || self.viewModel.secondaryHelper != nil {
                AdaptiveStack(
                    axis: .horizontal,
                    alignment: .top,
                    spacing: self.spacing,
                    accessibilityAlignment: .trailing,
                    showAccessibilityStack: isAccessibilityStack
                ) {
                    if let helper = self.viewModel.helper {
                        HStack(alignment: .top, spacing: self.spacing) {
                            self.helperImage?
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(
                                    width: self.iconSize,
                                    height: self.iconSize
                                )
                                .foregroundStyle(self.viewModel.helperColor.color)
                                .accessibilityIdentifier(FormFieldAccessibilityIdentifier.formFieldHelperImage)
                                .accessibilityHidden(true)

                            Text(helper)
                                .font(self.viewModel.helperFont.font)
                                .frame(minHeight: self.iconSize)
                                .foregroundStyle(self.viewModel.helperColor.color)
                                .titleFrame(isAccessibilityStack: isAccessibilityStack)
                                .accessibilityIdentifier(FormFieldAccessibilityIdentifier.formFieldHelperMessage)
                                .accessibilitySortPriority(2)
                                .accessibility(self.helperAccessibility)
                        }
                    }

                    OptionalHStack(onStack: isAccessibilityStack) {
                        Spacer(minLength: 0)

                        if let secondaryHelper = self.viewModel.secondaryHelper {
                            Text(secondaryHelper)
                                .font(self.viewModel.secondaryHelperFont.font)
                                .foregroundStyle(self.viewModel.secondaryHelperColor.color)
                                .frame(minHeight: self.iconSize)
                                .accessibilityIdentifier(FormFieldAccessibilityIdentifier.formFieldSecondaryHelperMessage)
                                .accessibilitySortPriority(1)
                                .accessibility(self.secondaryHelperAccessibility)
                        }
                    }
                }
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(FormFieldAccessibilityIdentifier.formField)
        .onChange(of: self.viewModel.titleAccessibilityLabel) { label in
            self.titleAccessibility.label = label
        }
    }

    // MARK: - Accessibility Modifier

    /// Set accessibility label for the *clear button* subview.
    /// - parameter label: the accessibility label.
    /// - Returns: The current view.
    public func clearButtonAccessibilityLabel(_ label: String) -> Self {
        var copy = self
        copy.clearButtonAccessibility.label = label
        return copy
    }

    /// Set accessibility label for the *title* subview.
    /// - parameter label: the accessibility label.
    /// - Returns: The current view.
    public func titleAccessibilityLabel(_ label: String) -> Self {
        self.viewModel.customTitleAccessibilityLabel = label
        return self
    }

    /// Set accessibility label for the *helper* subview.
    /// - parameter label: the accessibility label.
    /// - Returns: The current view.
    public func helperAccessibilityLabel(_ label: String) -> Self {
        var copy = self
        copy.helperAccessibility.label = label
        return copy
    }

    /// Set accessibility label for the *secondaryHelper* subview.
    /// - parameter label: the accessibility label.
    /// - Returns: The current view.
    public func secondaryHelperAccessibilityLabel(_ label: String) -> Self {
        var copy = self
        copy.secondaryHelperAccessibility.label = label
        return copy
    }

    /// Set accessibility value for the *secondaryHelper* subview.
    /// - parameter value: the accessibility value.
    /// - Returns: The current view.
    public func secondaryHelperAccessibilityValue(_ value: String) -> Self {
        var copy = self
        copy.secondaryHelperAccessibility.value = value
        return copy
    }

    // MARK: - Clear Button

    /// Add a clear button at the top right of the form field.
    /// - parameter title: the title of the clear button. **Optional**. If value is nil, a default localization value will be displayed (*clear/effacer*).
    /// - parameter icon: the icon of the clear button.
    /// - parameter action: the action on button tap.
    /// - Returns: The current view.
    ///
    /// ![FormField rendering with clear button.](component_clear_button.png)
    public func clearButton(
        title: String? = nil,
        icon: Image,
        action: @escaping @MainActor () -> Void
    ) -> Self {
        var copy = self
        copy.clearButton = ClearButton(
            title: title,
            icon: icon,
            action: {
                self.isComponentFocused = true
                action()
            }
        )
        return copy
    }

    // MARK: - Counter Modifier

    /// Display a counter value (X/Y) in the secondary helper label with a text and the limit.
    /// - parameter text: the text where the characters must be counted.
    /// - parameter limit: the counter limit. If the value is nil, the counter is not displayed.
    /// - Returns: The current view.
    ///
    /// ![FormField rendering with counter.](component_counter.png)
    public func counter(on text: String, limit: Int?) -> Self {
        self.viewModel.setCounter(textLength: text.count, limit: limit)
        return self
    }

    /// Display a counter value (X/Y) in the secondary helper label with a text length and the limit.
    /// - parameter textLength: the text length.
    /// - parameter limit: the counter limit. If the value is nil, the counter is not displayed.
    /// - Returns: The current view.
    ///
    /// ![FormField rendering with counter.](component_counter.png)
    public func counter(on textLength: Int, limit: Int?) -> Self {
        self.viewModel.setCounter(textLength: textLength, limit: limit)
        return self
    }
}

// MARK: - Extension

private extension View {

    @ViewBuilder
    func titleFrame(isAccessibilityStack: Bool) -> some View {
        if isAccessibilityStack {
            self.frame(maxWidth: .infinity, alignment: .leading)
        } else {
            self
        }
    }
}

// TODO: move to Common

// TODO: snapshot testing
/// An optional HStack view. If the `onStack` parameter is false, the content will be displayed without HStack.
// TODO: code example
public struct OptionalVStack<Content: View>: View {

    // MARK: - Properties

    private let alignment: HorizontalAlignment
    private let spacing: CGFloat?
    private let onStack: Bool
    @ViewBuilder private let content: () -> Content

    // MARK: - Initialization

    /// Creates a horizontal stack with the given spacing and vertical alignment.
    ///
    /// - Parameters:
    ///   - alignment: The guide for aligning the subviews in this stack. This
    ///     guide has the same vertical screen coordinate for every subview.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the stack to choose a default distance for each pair of
    ///     subviews.
    ///   - onStack: Display the content on stack or not.
    ///   - content: A view builder that creates the content of this stack.
    public init(
        alignment: HorizontalAlignment = .center,
        spacing: CGFloat? = nil,
        onStack: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.onStack = onStack
        self.content = content
    }

    // MARK: - View

    public var body: some View {
        if self.onStack {
            VStack(
                alignment: self.alignment,
                spacing: self.spacing,
                content: self.content
            )
        } else {
            self.content()
        }
    }
}

// TODO: snapshot testing
/// An optional HStack view. If the `onStack` parameter is false, the content will be displayed without HStack.
// TODO: code example
public struct OptionalHStack<Content: View>: View {

    // MARK: - Properties

    private let alignment: VerticalAlignment
    private let spacing: CGFloat?
    private let onStack: Bool
    @ViewBuilder private let content: () -> Content

    // MARK: - Initialization

    /// Creates a horizontal stack with the given spacing and vertical alignment.
    ///
    /// - Parameters:
    ///   - alignment: The guide for aligning the subviews in this stack. This
    ///     guide has the same vertical screen coordinate for every subview.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the stack to choose a default distance for each pair of
    ///     subviews.
    ///   - onStack: Display the content on stack or not.
    ///   - content: A view builder that creates the content of this stack.
    public init(
        alignment: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        onStack: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.onStack = onStack
        self.content = content
    }

    // MARK: - View

    public var body: some View {
        if self.onStack {
            HStack(
                alignment: self.alignment,
                spacing: self.spacing,
                content: self.content
            )
        } else {
            self.content()
        }
    }
}

// TODO: snapshot testing

/// A stack view that adapts its layout based on accessibility font size settings
// TODO: add example code
public struct AdaptiveStack<Content: View>: View {

    // MARK: - Enums

    /// Define Axis enum to match UIKit's NSLayoutConstraint.Axis
    public enum Axis {
        /// Horizontal implements a HStack
        case horizontal
        /// Vertical implements a HStack
        case vertical

        internal var accessibilityAxis: Self {
            switch self {
            case .horizontal: .vertical
            case .vertical: .horizontal
            }
        }
    }

    // MARK: - Properties

    // Environment value to detect accessibility settings
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    // Configuration for regular size category
    private let axis: Axis
    private let alignment: Alignment
    private let spacing: CGFloat?

    // Configuration for accessibility size category
    private let accessibilityAlignment: Alignment
    private let accessibilitySpacing: CGFloat?
    private let accessibilitySizeClass: UserInterfaceSizeClass?
    private let showAccessibilityStack: Bool?

    // Content to display
    @ViewBuilder private let content: () -> Content

    // MARK: - Initialization

    /// Initializes an adaptive stack that changes layout based on accessibility settings
    /// - Parameters:
    ///   - axis: The axis to use for regular size categories (default: horizontal)
    ///   - alignment: The alignment to use for regular size categories (default: center)
    ///   - spacing: The spacing to use for regular size categories (default: nil)
    ///   - accessibilityAlignment: The alignment to use for accessibility size categories (default: center)
    ///   - accessibilitySpacing: The spacing to use for accessibility size categories. If nil, the spacing of the stack will use the spacing parameter value (default: nil)
    ///   - accessibilitySizeClass: Use the accessibility stack only for if the screen size class is equals to this value or if the value is nil. (default: nil)
    ///   - content: The view builder that creates the content
    // TODO: add example code
    public init(
        axis: Axis = .horizontal,
        alignment: Alignment = .center,
        spacing: CGFloat? = nil,
        accessibilityAlignment: Alignment = .center,
        accessibilitySpacing: CGFloat? = nil,
        accessibilitySizeClass: UserInterfaceSizeClass? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.axis = axis
        self.alignment = alignment
        self.spacing = spacing
        self.accessibilityAlignment = accessibilityAlignment
        self.accessibilitySpacing = accessibilitySpacing
        self.accessibilitySizeClass = accessibilitySizeClass
        self.showAccessibilityStack = nil
        self.content = content
    }

    /// Initializes an adaptive stack that changes from your own rules (by *showAccessibilityStack* parameter)
    /// - Parameters:
    ///   - axis: The axis to use for regular size categories (default: horizontal)
    ///   - alignment: The alignment to use for regular size categories (default: center)
    ///   - spacing: The spacing to use for regular size categories (default: nil)
    ///   - accessibilityAlignment: The alignment to use for accessibility size categories (default: center)
    ///   - accessibilitySpacing: The spacing to use for accessibility size categories. If nil, the spacing of the stack will use the spacing parameter value (default: nil)
    ///   - showAccessibilityStack: The custom visibility of the accessibility stack
    ///   - content: The view builder that creates the content
    // TODO: add example code
    public init(
        axis: Axis = .horizontal,
        alignment: Alignment = .center,
        spacing: CGFloat? = nil,
        accessibilityAlignment: Alignment = .center,
        accessibilitySpacing: CGFloat? = nil,
        showAccessibilityStack: Bool,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.axis = axis
        self.alignment = alignment
        self.spacing = spacing
        self.accessibilityAlignment = accessibilityAlignment
        self.accessibilitySpacing = accessibilitySpacing
        self.accessibilitySizeClass = nil
        self.showAccessibilityStack = showAccessibilityStack
        self.content = content
    }

    // MARK: - View

    public var body: some View {
        if self.isAccessibilityStack() {
            // Use accessibility configuration
            switch self.axis.accessibilityAxis {
            case .horizontal:
                HStack(
                    alignment: self.accessibilityAlignment.vertical, spacing: self.accessibilitySpacing ?? self.spacing, content: self.content)
            case .vertical:
                VStack(alignment: self.accessibilityAlignment.horizontal, spacing: self.accessibilitySpacing ?? self.spacing, content: self.content)
            }
        } else {
            // Use regular configuration
            switch self.axis {
            case .horizontal:
                HStack(alignment: self.alignment.vertical, spacing: self.spacing, content: self.content)
            case .vertical:
                VStack(alignment: self.alignment.horizontal, spacing: self.spacing, content: self.content)
            }
        }
    }

    // MARK: - Getter

    func isAccessibilityStack() -> Bool {
        return if let showAccessibilityStack {
            showAccessibilityStack
        } else {
            self.dynamicTypeSize.isAccessibilitySize && (self.accessibilitySizeClass == nil || self.horizontalSizeClass == self.accessibilitySizeClass)
        }
    }
}

// TODO: tester
internal extension Alignment {

    // Helper to convert general alignment to HorizontalAlignment for VStack
    private var horizontal: HorizontalAlignment {
        return switch self {
        case .leading, .topLeading, .bottomLeading:
            .leading
        case .trailing, .topTrailing, .bottomTrailing:
            .trailing
        default:
            .center
        }
    }

    // Helper to convert general alignment to VerticalAlignment for HStack
    private var vertical: VerticalAlignment {
        return switch self {
        case .top, .topLeading, .topTrailing:
            .top
        case .bottom, .bottomLeading, .bottomTrailing:
            .bottom
        case .centerFirstTextBaseline:
            .firstTextBaseline
        default:
            .center
        }
    }
}
