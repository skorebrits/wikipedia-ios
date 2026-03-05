//
//  AlertViewModifier.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import SwiftUI

struct AlertViewModifier: ViewModifier {

    @Binding var isPresented: Bool
    var viewData: AlertViewData
    var onDismiss: () -> Void

    func body(content: Content) -> some View {
        content
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text(viewData.title),
                    message: Text(viewData.message),
                    dismissButton: .default(Text(viewData.dismissButton), action: onDismiss)
                )
            }
    }
}
