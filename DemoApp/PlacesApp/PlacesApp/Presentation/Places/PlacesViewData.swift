//
//  PlacesViewData.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 08/03/2026.
//

protocol ViewDataWithTitle {
    var title: String { get }
}

struct PlacesViewData: ViewDataWithTitle {
    let title: String
    let cellViewData: [PlacesCellViewData]
}
