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
        .overlay(alignment: .bottomTrailing) {
            Button {
                viewModel.showCreateLocation = true
            } label: {
                Image(systemName: "square.and.pencil")
                    .font(.title2)
                    .frame(width:56, height: 56)
            }
            .buttonStyle(.glass)
            .padding()
        }
        .task {
            await viewModel.fetchLocations()
        }
        .modifier(
            AlertViewModifier(
                isPresented: $viewModel.showAlert,
                viewData: viewModel.alertViewData,
                onDismiss: {
                    viewModel.showAlert = false
                }
            )
        )
        .sheet(isPresented: $viewModel.showCreateLocation) {
            CreateLocationView(
                isPresented: $viewModel.showCreateLocation,
                onSubmit: { location in
                    viewModel.addLocation(location: location)
                }
            )
            .presentationDetents([.medium, .large])
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
