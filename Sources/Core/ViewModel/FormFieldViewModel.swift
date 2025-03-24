//
//  FormFieldViewModel.swift
//  SparkFormField
//
//  Created by alican.aycil on 30.01.24.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import Combine
import SwiftUI
import UIKit
import SparkTheming

final class FormFieldViewModel<AS: SparkAttributedString>: ObservableObject {

    // MARK: - Internal properties
    @Published private(set) var title: AS?
    @Published private(set) var titleFont: any TypographyFontToken
    @Published private(set) var titleColor: any ColorToken

    @Published var helper: AS?
    @Published private(set) var helperFont: any TypographyFontToken
    @Published private(set) var helperColor: any ColorToken

    @Published private(set) var secondaryHelper: String?
    @Published private(set) var secondaryHelperFont: any TypographyFontToken
    @Published private(set) var secondaryHelperColor: any ColorToken

    @Published private(set) var spacing: CGFloat

    var theme: Theme {
        didSet {
            self.updateColors()
            self.updateFonts()
            self.updateSpacing()
            self.updateTitle()
        }
    }

    var feedbackState: FormFieldFeedbackState {
        didSet {
            guard feedbackState != oldValue else { return }
            self.updateColors()
        }
    }

    var isTitleRequired: Bool {
        didSet {
            guard isTitleRequired != oldValue else { return }
            self.updateTitle()
        }
    }

    var colors: FormFieldColors

    private var colorUseCase: FormFieldColorsUseCaseable
    private var titleUseCase: FormFieldTitleUseCaseable
    private var userDefinedTitle: AS?

    // MARK: - Init
    init(
        theme: Theme,
        feedbackState: FormFieldFeedbackState,
        title: AS?,
        helper: AS?,
        isTitleRequired: Bool = false,
        colorUseCase: FormFieldColorsUseCaseable = FormFieldColorsUseCase(),
        titleUseCase: FormFieldTitleUseCaseable = FormFieldTitleUseCase()
    ) {
        self.theme = theme
        self.feedbackState = feedbackState
        self.helper = helper
        self.isTitleRequired = isTitleRequired
        self.colorUseCase = colorUseCase
        self.titleUseCase = titleUseCase
        self.colors = colorUseCase.execute(from: theme, feedback: feedbackState)
        self.spacing = Self.spacing(from: theme)
        self.titleFont = Self.titleFont(from: theme)
        self.titleColor = self.colors.title
        self.helperFont = Self.helperFont(from: theme)
        self.helperColor = self.colors.helper
        self.secondaryHelperFont = Self.secondaryHelperFont(from: theme)
        self.secondaryHelperColor = self.colors.secondaryHelper
        self.setTitle(title)
    }

    // MARK: - Setter

    func setTitle(_ title: AS?) {
        self.userDefinedTitle = title
        self.updateTitle()
    }

    func setCounter(text: String?, limit: Int?) {
        self.setCounter(textLength: text?.count, limit: limit)
    }

    func setCounter(textLength: Int?, limit: Int?) {
        guard let limit else {
            self.secondaryHelper = nil
            return
        }

        self.secondaryHelper = "\(textLength ?? 0)/\(limit)"
    }

    // MARK: - Private Update

    private func updateTitle() {
        self.title = self.titleUseCase.execute(title: self.userDefinedTitle, isTitleRequired: self.isTitleRequired, colors: self.colors, typography: self.theme.typography) as? AS
    }

    private func updateColors() {
        self.colors = self.colorUseCase.execute(from: self.theme, feedback: self.feedbackState)
        self.titleColor = self.colors.title
        self.helperColor = self.colors.helper
        self.secondaryHelperColor = self.colors.secondaryHelper
    }

    private func updateFonts() {
        self.titleFont = Self.titleFont(from: self.theme)
        self.helperFont = Self.helperFont(from: self.theme)
        self.secondaryHelperFont = Self.secondaryHelperFont(from: self.theme)
    }

    private func updateSpacing() {
        self.spacing = Self.spacing(from: self.theme)
    }

    // MARK: - Static func

    private static func titleFont(from theme: Theme) -> any TypographyFontToken {
        return theme.typography.body2
    }

    private static func helperFont(from theme: Theme) -> any TypographyFontToken {
        return theme.typography.caption
    }

    private static func secondaryHelperFont(from theme: Theme) -> any TypographyFontToken {
        return theme.typography.caption
    }

    private static func spacing(from theme: Theme) -> CGFloat {
        return theme.layout.spacing.small
    }
}
