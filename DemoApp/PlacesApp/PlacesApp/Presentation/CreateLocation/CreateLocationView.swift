//
//  CreateLocationView.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import SwiftUI

struct CreateLocationView: View {

    @State private var viewModel: CreateLocationViewModel = .init()
    @Binding var isPresented: Bool
    var onSubmit: (Location) -> Void

    private let labelWidth: CGFloat = 110.0

    var body: some View {
        VStack(spacing: 12) {
            Text(viewModel.viewData.title)
                .font(.title)
                .accessibilityAddTraits(.isHeader)

            Spacer()
                .frame(height: 24)

            LabeledTextFieldView(
                label: viewModel.viewData.labelName,
                labelWidth: labelWidth,
                keyboardType: .default,
                text: $viewModel.nameField,
                onChange: {
                    viewModel.validateLocation()
                }
            )

            LabeledTextFieldView(
                label: viewModel.viewData.labelLongitude,
                labelWidth: labelWidth,
                keyboardType: .decimalPad,
                text: $viewModel.longitudeField,
                onChange: {
                    viewModel.validateLocation()
                }
            )

            LabeledTextFieldView(
                label: viewModel.viewData.labelLatitude,
                labelWidth: labelWidth,
                keyboardType: .decimalPad,
                text: $viewModel.latitudeField,
                onChange: {
                    viewModel.validateLocation()
                }
            )

            Spacer()
                .frame(height: 24)

            Button {
                isPresented = false
                onSubmit(
                    viewModel.location
                )
            } label: {
                Text(viewModel.viewData.buttonOk)
                    .frame(maxWidth: .infinity)
            }
            .disabled(!viewModel.viewData.buttonOkEnabled)
            .buttonStyle(.borderedProminent)
            .accessibilityLabel(viewModel.viewData.buttonOk)
            .accessibilityHint(viewModel.viewData.buttonOkHint)

            Button {
                isPresented = false
            } label: {
                Text(viewModel.viewData.buttonCancel)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .accessibilityLabel(viewModel.viewData.buttonCancel)
            .accessibilityHint(viewModel.viewData.buttonCancelHint)
        }
        .controlSize(.large)
        .padding(12)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CreateLocationView(
        isPresented: .constant(true)
    ) { location in
        debugPrint("Location  \(location)")
    }
}
