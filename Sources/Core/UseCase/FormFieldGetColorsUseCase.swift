//
//  FormFieldGetColorsUseCase.swift
//  SparkFormField
//
//  Created by alican.aycil on 31.01.24.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import SparkTheming

// sourcery: AutoMockable
protocol FormFieldGetColorsUseCaseable {
    func execute(from theme: Theme, feedback state: FormFieldFeedbackState) -> FormFieldColors
}

struct FormFieldGetColorsUseCase: FormFieldGetColorsUseCaseable {

    func execute(from theme: Theme, feedback state: FormFieldFeedbackState) -> FormFieldColors {
        let commonColor = theme.colors.base.onSurface.opacity(theme.dims.dim1)
        switch state {
        case .default:
            return .init(
                title: theme.colors.base.onSurface,
                require: commonColor,
                helper: commonColor,
                secondaryHelper: commonColor
            )
        case .error:
            return .init(
                title: theme.colors.base.onSurface,
                require: commonColor,
                helper: theme.colors.feedback.error,
                secondaryHelper: commonColor
            )
        }
    }
}
