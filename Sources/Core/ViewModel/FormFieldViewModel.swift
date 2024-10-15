//
//  FormFieldViewModel.swift
//  SparkFormField
//
//  Created by alican.aycil on 30.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
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

    @Published private(set) var info: String?
    @Published private(set) var infoFont: any TypographyFontToken
    @Published private(set) var infoColor: any ColorToken

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
        self.infoFont = Self.infoFont(from: theme)
        self.infoColor = self.colors.info
        self.setTitle(title)
    }

    // MARK: - Setter

    func setTitle(_ title: AS?) {
        self.userDefinedTitle = title
        self.updateTitle()
    }

    func setCounter(text: String?, limit: Int?) {
        guard let limit else {
            self.info = nil
            return
        }

        self.info = "\(text?.count ?? 0)/\(limit)"
    }

    // MARK: - Private Update

    private func updateTitle() {
        self.title = self.titleUseCase.execute(title: self.userDefinedTitle, isTitleRequired: self.isTitleRequired, colors: self.colors, typography: self.theme.typography) as? AS
    }

    private func updateColors() {
        self.colors = self.colorUseCase.execute(from: self.theme, feedback: self.feedbackState)
        self.titleColor = self.colors.title
        self.helperColor = self.colors.helper
        self.infoColor = self.colors.info
    }

    private func updateFonts() {
        self.titleFont = Self.titleFont(from: self.theme)
        self.helperFont = Self.helperFont(from: self.theme)
        self.infoFont = Self.infoFont(from: self.theme)
    }

    private func updateSpacing() {
        self.spacing = Self.spacing(from: self.theme)
    }

    // MARK: - Static func

    private static func titleFont(from theme: Theme) -> any TypographyFontToken {
        theme.typography.body2
    }

    private static func helperFont(from theme: Theme) -> any TypographyFontToken {
        theme.typography.caption
    }

    private static func infoFont(from theme: Theme) -> any TypographyFontToken {
        theme.typography.caption
    }

    private static func spacing(from theme: Theme) -> CGFloat {
        theme.layout.spacing.small
    }
}
