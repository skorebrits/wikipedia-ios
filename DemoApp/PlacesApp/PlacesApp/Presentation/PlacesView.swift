//
//  PlacesView.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import SwiftUI

struct PlacesView: View {

    @State private var viewModel = PlacesViewModel()

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                LoadingView()
            case .error(let errorViewData):
                ErrorView(viewData: errorViewData) {
                    Task {
                        await viewModel.fetchLocations()
                    }
                }
            case .loaded:
                Text("Did load")
            }
        }.task {
            await viewModel.fetchLocations()
        }
    }
}

#Preview {
    PlacesView()
}
