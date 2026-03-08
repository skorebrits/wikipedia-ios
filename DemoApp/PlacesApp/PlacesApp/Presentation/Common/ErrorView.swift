//
//  ErrorView.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import SwiftUI

struct ErrorView: View {
    var viewData: ErrorViewData
    var onRetry: () -> Void

    var body: some View {
        VStack(spacing: 6) {
            Text(viewData.errorLabel)
                .accessibilityAddTraits(.isStaticText)

            Button(viewData.errorButton) {
                onRetry()
            }
            .accessibilityLabel(viewData.errorButton)
            .accessibilityHint(viewData.errorButtonHint)
        }
    }
}

#Preview {
    ErrorView(viewData:
            .init(
                errorLabel: "label",
                errorButton: "button",
                errorButtonHint: "Retry"
            )
    ) {
        debugPrint("retry")
    }
}
