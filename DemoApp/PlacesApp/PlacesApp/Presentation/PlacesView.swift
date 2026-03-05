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
        NavigationStack {
            content
                .navigationTitle(String(localized: "places.title"))
        }
        .task {
            await viewModel.fetchLocations()
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            LoadingView()
        case .error(let errorViewData):
            ErrorView(viewData: errorViewData) {
                Task {
                    await viewModel.fetchLocations()
                }
            }
        case .loaded(let placesViewData):
            List(placesViewData) { viewData in
                PlacesCellView(viewData: viewData) { id in
                    viewModel.select(id: id)
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    PlacesView()
}
