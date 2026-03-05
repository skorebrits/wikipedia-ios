//
//  PlacesState.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

enum PlacesState {
    case loading
    case error(ErrorViewData)
    case loaded([PlacesCellViewData])
}
