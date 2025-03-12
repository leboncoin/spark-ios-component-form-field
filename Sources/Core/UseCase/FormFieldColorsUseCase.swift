//
//  FormFieldColorsUseCase.swift
//  SparkFormField
//
//  Created by alican.aycil on 31.01.24.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import SparkTheming

// sourcery: AutoMockable
protocol FormFieldColorsUseCaseable {
    func execute(from theme: Theme, feedback state: FormFieldFeedbackState) -> FormFieldColors
}

struct FormFieldColorsUseCase: FormFieldColorsUseCaseable {

    func execute(from theme: Theme, feedback state: FormFieldFeedbackState) -> FormFieldColors {
        let commonColor = theme.colors.base.onSurface.opacity(theme.dims.dim1)
        switch state {
        case .default:
            return FormFieldColors(
                title: theme.colors.base.onSurface,
                helper: commonColor,
                asterisk: commonColor,
                secondaryHelper: commonColor
            )
        case .error:
            return FormFieldColors(
                title: theme.colors.base.onSurface,
                helper: theme.colors.feedback.error,
                asterisk: commonColor,
                secondaryHelper: commonColor
            )
        }
    }
}
