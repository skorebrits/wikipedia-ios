//
//  CreateLocationView.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import SwiftUI

struct CreateLocationView: View {

    var viewData: CreateLocationViewData
    @Binding var isPresented: Bool
    var onSubmit: (Location) -> Void

    @State private var nameField = "name"
    @State private var longitudeField = "0.0"
    @State private var latitudeField = "0.0"

    private let labelWidth: CGFloat = 110.0

    var body: some View {
        VStack(spacing: 12) {
            Text(viewData.title)
                .font(.title)

            Spacer()
                .frame(height: 24)

            HStack {
                Text("\(viewData.labelName):")
                    .font(.title2)
                    .frame(width: labelWidth, alignment: .leading)

                TextField(viewData.labelName, text: $nameField)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
            }

            HStack {
                Text("\(viewData.labelLongitude):")
                    .font(.title2)
                    .frame(width: labelWidth, alignment: .leading)

                TextField(viewData.labelLongitude, text: $longitudeField)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
            }

            HStack {
                Text("\(viewData.labelLatitude):")
                    .font(.title2)
                    .frame(width: labelWidth, alignment: .leading)

                TextField(viewData.labelLatitude, text: $latitudeField)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
            }

            Spacer()
                .frame(height: 24)

            Button {
                isPresented = false
                //TODO: Location Validation. Out of spec
                onSubmit(
                    Location(
                        name: nameField,
                        longitude: Double(longitudeField) ?? 0.0,
                        latitude: Double(latitudeField) ?? 0.0
                    )
                )
            } label: {
                Text(viewData.buttonOk)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)

            Button {
                isPresented = false
            } label: {
                Text(viewData.buttonCancel)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .controlSize(.large)
    }
}

#Preview {
    CreateLocationView(viewData: .init(
        title: "Create Location", 
        labelName: "Name",
        labelLongitude: "Longitude",
        labelLatitude: "Latitude",
        buttonOk: "Ok",
        buttonCancel: "Cancel"
    ),
        isPresented: .constant(true)
    ) { location in
        debugPrint("Location  \(location.longitude) \(location.latitude)")
    }
}
