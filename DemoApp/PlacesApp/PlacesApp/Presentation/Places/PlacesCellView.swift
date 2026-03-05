//
//  Untitled.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import SwiftUI

struct PlacesCellView: View {

    var viewData: PlacesCellViewData
    var onDidTap: (String) -> Void

    var body: some View {
        Button {
            onDidTap(viewData.id)
        } label: {
            HStack {
                Text(viewData.name)
                    .padding()
                    .font(.title)
                Spacer()
            }
            .contentShape(Rectangle())
        }
    }
}

#Preview {
    PlacesCellView(viewData: .init(id: "id", name: "name"), onDidTap: { id in
        debugPrint("did tap \(id)")
    })
}
