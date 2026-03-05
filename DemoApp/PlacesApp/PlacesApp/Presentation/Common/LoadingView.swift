//
//  LoadingView.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import SwiftUI

struct LoadingView: View {

    var body: some View {
        ProgressView()
            .tint(.blue)
            .progressViewStyle(.circular)
    }
}

#Preview {
    LoadingView()
}
