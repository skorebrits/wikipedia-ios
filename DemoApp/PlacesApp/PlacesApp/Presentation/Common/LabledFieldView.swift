//
//  LabeledTextFieldView.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 08/03/2026.
//

import SwiftUI

struct LabeledTextFieldView: View {

    let label: String
    let labelWidth: CGFloat
    var keyboardType: UIKeyboardType
    @Binding var text: String
    var onChange: () -> Void

    var body: some View {
        HStack {
            Text("\(label):")
                .font(.title2)
                .frame(width: labelWidth, alignment: .leading)

            TextField(label, text: $text)
                .textFieldStyle(.roundedBorder)
                .onChange(of: text) {
                    onChange()
                }
        }
    }
}

#Preview {
    LabeledTextFieldView(
        label: "Label",
        labelWidth: 100,
        keyboardType: .default,
        text: .constant("text")
    ) {
        debugPrint("did update")
    }
}
